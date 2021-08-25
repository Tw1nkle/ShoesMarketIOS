//
//  Home.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.08.2021.
//

import SwiftUI
import Firebase

struct Home: View {
    
    // MARK: - PROPERTIES
    
    @AppStorage("log_Status") var status = false
    @StateObject private var state = StateModel()
    @StateObject var shopData = ShopViewModel()
    
    // Moving image to top like hero animation
    @Namespace var animation
    
    // MARK: - BODY
    
    var body: some View {
    
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                NavigationBarView(state: state)
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    .environmentObject(shopData)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        
                        // Slider
                        FeaturedTabView()
                            .padding(.vertical, 20)
                            .frame(height: 270)
                        
                        // Category
                        CategoryGridView(state: state)
                        
                        //Title
                        TitleView(title: "Новинки")
                        
                        // Product
                        LazyVGrid(columns: gridLayoutVertical, spacing: 15, content: {
                            ForEach(products) { product in
                                ProductItemView(product: product)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            shopData.selectedProduct = product
                                            shopData.showingProduct = true
                                            shopData.showCart.toggle()
                                        }
                                    }
                            } //: LOOP
                        }) //: GRID
                        .padding(15)
                        
                        // Footer
                        FooterView()
                            .padding(.horizontal)
                        
                        // Sign Out
                        Button(action: {
                            // Loggin out
                            try? Auth.auth().signOut()
                            withAnimation{status = false}
                        }, label: {
                            Text("Выйти из аккаунта")
                                .fontWeight(.heavy)
                        }) //: BUTTON
                        .padding(.bottom, 50)
                    } //: VSTACK
                }) //: SCROLL
                
            } //: VSTACK
            // Blurring when cart is opened
            .blur(radius: shopData.showCart ? 20 : 0)
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            .fullScreenCover(item: $state.fullScreenToShow, content: { content in
                content
            })
            
            ProductDetailView(animation: animation)
                // Closing when animation started
                .offset(y: shopData.showCart ? shopData.startAnimation ? 500 : 0 : 500)
                .environmentObject(shopData)
            
            // Animations
            if shopData.startAnimation {
                VStack {
                    Spacer()
                    
                    ZStack {
                        
                        // Circle animation effect
                        Color.white
                            .frame(width: shopData.shoeAnimation ? 100 : getRect().width * 1.3, height: shopData.shoeAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                        
                        // Opacit
                            .opacity(shopData.shoeAnimation ? 1 : 0)
                        
                        Image(shopData.selectedProduct?.image ?? sampleProduct.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .frame(width: 80, height: 80)
                    } //: ZTACK
                    .offset(y: shopData.saveCart ? 70 : -120)
                    // Scaling effect
                    .scaleEffect(shopData.saveCart ? 0.6 : 1)
                    .onAppear(perform: shopData.performAnimations)
                    
                    if !shopData.saveCart {
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(shopData.addItemToCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(shopData.addItemToCart ? Color.orange : Color.yellow)
                        .clipShape(Circle())
                        .offset(y: shopData.showBag ? -50 : 300)
                    
                } //: VSTACK
                // Setting external view width to screen width
                .frame(width: getRect().width)
                // Moving view down
                .offset(y: shopData.endAnimation ? 500 : 0)
                
            }
            
        } //: ZTACK
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: shopData.endAnimation, perform: { value in
            if shopData.endAnimation {
                shopData.resetAll()
            }
        })
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}

// MARK: - PROPERTIES

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(ShopViewModel())
    }
}

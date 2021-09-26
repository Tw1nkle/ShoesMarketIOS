//
//  WomanView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.09.2021.
//

import SwiftUI

struct WomanView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @EnvironmentObject var state: StateModel
    @State private var isBack = false
    
    // Moving image to top like hero animation
    @Namespace var animation
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        self.isBack = true
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .foregroundColor(.black)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                    })
                    .padding()
                    
                    TitleCategory(title: "Женщины")
                    
                    Spacer()
                } //: HSTACK
                
                ScrollView(.vertical, showsIndicators: false, content: {
                        // Product
                        LazyVGrid(columns: gridLayoutVertical, spacing: 15, content: {
                            ForEach(products.filter({"\($0)".contains("Женские")})) { product in
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
                }) //: SCROLL
            } //: VSTACK
            // Blurring when cart is opened
            .blur(radius: shopData.showCart ? 20 : 0)
            .background(Color.white.ignoresSafeArea(.all, edges: .all))
            
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
                
            } //: ENDIF
            
        } //: ZTACK
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onReceive(shopData.$endAnimation, perform: { value in
            if value {
                shopData.resetAll()
            }
        })
    }
}

struct WomanView_Previews: PreviewProvider {
    static var previews: some View {
        WomanView()
            .environmentObject(ShopViewModel())
            .environmentObject(StateModel())
    }
}

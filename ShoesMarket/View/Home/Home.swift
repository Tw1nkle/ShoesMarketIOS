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
    
    //@EnvironmentObject var shop: ShopViewModel
    @AppStorage("log_Status") var status = false
    @StateObject private var state = StateModel()
    @StateObject var shopData = ShopViewModel()
    
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
                    } //: VSTACK
                }) //: SCROLL
                
            } //: VSTACK
            // Blurring when cart is opened
            .blur(radius: shopData.showCart ? 20 : 0)
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            .fullScreenCover(item: $state.fullScreenToShow, content: { content in
                content
            })
            
            ProductDetailView()
                // Hiding view when shoes is not selected
                // Like botton sheet
                .offset(y: shopData.showCart ? 0 : 500)
                // Setting environment object so as to access ie easier
                .environmentObject(shopData)
            
        } //: ZTACK
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        
    }
}

// MARK: - PROPERTIES

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

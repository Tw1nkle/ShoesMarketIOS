//
//  WomanView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 19.08.2021.
//

import SwiftUI

struct WomanView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    
    // Moving image to top like hero animation
    @Namespace var animation
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                // Кнопка назад!!!!!!!!!!!!!!!!!!
                TitleView(title: "Женщины")
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
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
                    } //: VSTACK
                }) //: SCROLL
            } //: VSTACK
            .blur(radius: shopData.showCart ? 20 : 0)
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

// MARK: - PREVIEW

struct WomanView_Previews: PreviewProvider {
    static var previews: some View {
        WomanView()
            .environmentObject(ShopViewModel())
    }
}

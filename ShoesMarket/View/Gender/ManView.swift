//
//  ManView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.09.2021.
//

import SwiftUI

struct ManView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @EnvironmentObject var state: StateModel
    @State private var isBack = false
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
                        .padding(.leading, 15)
                    
                    // Название категории
                    TitleCategory(title: "Мужская обувь")
                    
                    Spacer()
                } //: HSTACK
                
                ScrollView(.vertical, showsIndicators: false, content: {
                        // Product
                        LazyVGrid(columns: gridLayoutVertical, spacing: 25, content: {
                            ForEach(products.filter({"\($0)".contains("Мужские")})) { product in
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
            .blur(radius: shopData.showCart ? 3 : 0)
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            
            ProductMainDetailView(animation: animation)
                .offset(y: shopData.showCart ? shopData.startAnimation ? 1000 : 0 : 1000)
                .environmentObject(shopData)
            
            // Animations
            if shopData.startAnimation {
                VStack {
                    Spacer()
                    
                    ZStack {
                        Color.white
                            .frame(width: shopData.shoeAnimation ? 100 : getRect().width * 1.3, height: shopData.shoeAnimation ? 100 : getRect().width * 1.3)
                            .clipShape(Circle())
                            .opacity(shopData.shoeAnimation ? 1 : 0)
                        
                        Image(shopData.selectedProduct?.image ?? sampleProduct.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .matchedGeometryEffect(id: "SHOE", in: animation)
                            .frame(width: 80, height: 80)
                    } //: ZTACK
                    .offset(y: shopData.saveCart ? 70 : -120)
                    .scaleEffect(shopData.saveCart ? 0.6 : 1)
                    .onAppear(perform: shopData.performAnimations)
                    
                    if !shopData.saveCart {
                        Spacer()
                    }
                    
                    Image(systemName: "bag\(shopData.addItemToCart ? ".fill" : "")")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(shopData.addItemToCart ? darkenColor : buttonColor)
                        .clipShape(Circle())
                        .offset(y: shopData.showBag ? -50 : 300)
                } //: VSTACK
                .frame(width: getRect().width)
                .offset(y: shopData.endAnimation ? 500 : 0)
                
            } //: ENDIF
            
        } //: ZTACK
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.ignoresSafeArea())
        .onReceive(shopData.$endAnimation, perform: { value in
            if value {
                shopData.resetAll()
            }
        })
    }
}

// MARK: - PREVIEW
struct ManView_Previews: PreviewProvider {
    static var previews: some View {
        ManView()
            .environmentObject(ShopViewModel())
            .environmentObject(StateModel())
    }
}

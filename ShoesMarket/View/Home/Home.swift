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
    @Environment(\.presentationMode) private var presentationMode
    @AppStorage("log_Status") var status = false
    @StateObject var state = StateModel()
    @StateObject var shopData = ShopViewModel()
    @Namespace var animation
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                NavigationBarView()
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white.shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0))
                    .environmentObject(shopData)
                    .environmentObject(state)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        // Слайдер
                        FeaturedTabView()
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
                            .padding(.vertical, 20)
                            .frame(height: 270)
                        
                        // Категории
                        CategoryGridView()
                            .environmentObject(state)
                        
                        // Заголовок
                        TitleView(title: "Новинки")
                        
                        // Товар новинок
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(products) { product in
                                    if product.new == true {
                                        ProductItemView(product: product)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    shopData.selectedProduct = product
                                                    shopData.showingProduct = true
                                                    shopData.showCart.toggle()
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.top, 10)
                        
                        // Заголовок
                        TitleView(title: "Лучшая цена")
                        
                        // Товар с лучшими ценами
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(products) { product in
                                    if product.discount > 0 {
                                        ProductItemView(product: product)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    shopData.selectedProduct = product
                                                    shopData.showingProduct = true
                                                    shopData.showCart.toggle()
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        .padding(.top, 10)
                        
                        FooterView()
                            .padding(.horizontal)
                        
                        // Выход из аккаунта
                        Button(action: {
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
            .blur(radius: shopData.showCart ? 3 : 0)
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            .fullScreenCover(item: $state.fullScreenToShow, content: { content in
                content
                    .environmentObject(shopData)
                    .environmentObject(state)
            })
            
            ProductMainDetailView(animation: animation)
                .offset(y: shopData.showCart ? shopData.startAnimation ? 1000 : 0 : 1000)
                .environmentObject(shopData)
            
            // Анимация добавления товара в корзину
            if shopData.startAnimation && state.fullScreenToShow == nil {
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
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(colorBackground.ignoresSafeArea())
        .onReceive(shopData.$endAnimation, perform: { value in
            if value && state.fullScreenToShow == nil {
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

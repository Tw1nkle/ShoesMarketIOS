//
//  SearchView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 30.08.2021.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @EnvironmentObject var state: StateModel
    @State private var isEditing = false
    @Namespace var animation
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack {
                    TextField("Поиск", text: $shopData.searchQuery)
                        .padding(15)
                        .padding(.horizontal, 25)
                        .background(Color.gray.opacity(0.10))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 15)
                                
                                if isEditing {
                                    Button(action: {
                                        shopData.searchQuery = ""
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            } //: HSTACK
                        )
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                        Button(action: {
                            self.isEditing = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Отменить")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        })
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                } //: HSTACK
                .padding()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVGrid(columns: gridLayoutVertical, spacing: 15, content: {
                            ForEach(products.filter({"\($0)".contains(shopData.searchQuery) || shopData.searchQuery.isEmpty})) { product in
                                ProductItemView(product: product)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            shopData.selectedProduct = product
                                            shopData.showingProduct = true
                                            shopData.showCart.toggle()
                                        }
                                    }
                                    .padding(.bottom, 10)
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
                .padding(.top, -50)
            
            if shopData.startAnimation {
                VStack {
                    Spacer()
                    
                    ZStack {
                        
                        // Эффект круговой анимации
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
        .onReceive(shopData.$endAnimation, perform: { value in
            if value {
                shopData.resetAll()
            }
        })
    }
}

// MARK: - PREVIEW
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ShopViewModel())
            .environmentObject(StateModel())
    }
}

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
    @StateObject var shopData = ShopViewModel()
    @StateObject private var state = StateModel()
    @State private var isEditing = false
    
    // Moving image to top like hero animation
    @Namespace var animation
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                HStack {
                    TextField("Поиск", text: $shopData.searchQuery)
                        .padding(15)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
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
                    
                    if isEditing {
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
                    }
                    
                } //: HSTACK
                .padding()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        
                        // Product
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
                            } //: LOOP
                        }) //: GRID
                        .padding(15)
                        
                    } //: VSTACK
                }) //: SCROLL
            } //: VSTACK
            // Blurring when cart is opened
            .blur(radius: shopData.showCart ? 20 : 0)
            .background(Color.white.ignoresSafeArea(.all, edges: .all))
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
//        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.04).ignoresSafeArea())
        .onChange(of: shopData.endAnimation, perform: { value in
            if shopData.endAnimation {
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
    }
}

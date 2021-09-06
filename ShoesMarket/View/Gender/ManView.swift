//
//  ManView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 19.08.2021.
//

import SwiftUI

struct ManView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @State private var isBack = false
    
    // Moving image to top like hero animation
    @Namespace var animation
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
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
                    
                    TitleCategory(title: "Мужчины")
                    
                    Spacer()
                } //: HSTACK
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        // Product
                        LazyVGrid(columns: gridLayoutVertical, spacing: 15, content: {
                            ForEach(products.filter({"\($0)".contains("Мужские")})) { product in
                                ProductItemView(product: product)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            shopData.selectedProduct = product
                                            shopData.showingProduct = true
                                            shopData.showCart = true
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
        } //: ZTACK
    }
}

// MARK: - PREVIEW
struct ManView_Previews: PreviewProvider {
    static var previews: some View {
        ManView()
            .environmentObject(ShopViewModel())
    }
}

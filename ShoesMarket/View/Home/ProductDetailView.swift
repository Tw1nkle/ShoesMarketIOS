//
//  ProductDetailView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI

struct ProductDetailView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var shopData: ShopViewModel
    var animation: Namespace.ID
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                
                if !shopData.startAnimation {
                    // Image
                    Image(shopData.selectedProduct?.image ?? sampleProduct.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .trailing, spacing: 10, content: {
                    
                    // Title
                    Text(shopData.selectedProduct?.name ?? sampleProduct.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                    
                    // Gender
                    Text(shopData.selectedProduct?.sex ?? sampleProduct.sex)
                    
                    // Price
                    Text(shopData.selectedProduct?.formattedPrice ?? sampleProduct.formattedPrice)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                }) //: VSTACK
                
            } //: HSTACK
            .padding()
            
            Divider()
            
            Text("Выберите размер")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            // Size
            LazyVGrid(columns: columnSize, alignment: .leading, spacing: 15, content: {
                ForEach(shopData.selectedProduct?.sizes ?? sampleProduct.sizes, id: \.self) { size in
                    Button(action: {
                        withAnimation{
                            shopData.selectedSize = size
                        }
                    }, label: {
                        Text(size)
                            .fontWeight(.semibold)
                            .foregroundColor(shopData.selectedSize == size ? .white : .black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(shopData.selectedSize == size ? Color.yellow : Color.black.opacity(0.06))
                            .cornerRadius(10)
                    }) //: BUTTON
                }
            }) //: LAZY
            .padding(.top)
            
            // Add to cart
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)) {
                    shopData.startAnimation = true
                }
            }, label: {
                Text("Добавить в корзину")
                    .fontWeight(.bold)
                    .foregroundColor(shopData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(shopData.selectedSize == "" ? Color.black.opacity(0.06) : Color.yellow)
                    .cornerRadius(18)
            }) //: BUTTON
            // Disabling button when no size selected
            .disabled(shopData.selectedSize == "")
            .padding(.top)
            
        } //: VSTACK
        .padding()
        .padding(.bottom, 20)
        .background(Color.white.clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 35)))
    }
}

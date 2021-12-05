//
//  ProductItemView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 22.08.2021.
//

import SwiftUI

struct ProductItemView: View {
    
    // MARK: - PROPERTIES
    let product: Product
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            ZStack {
                
                if product.discount > 0 {
                    Text("-\(product.discount)%")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.red)
                        .cornerRadius(10)
                        .offset(x: -50, y: -70)
                }
                
                // Изображение
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 165, height: 100)
            } //: ZTACK
            .frame(width: 175, height: 180)
            .background(Color.white)
            .cornerRadius(20)
            
            // Название
            Text("\(product.name)")
                .font(.system(size: 16))
                .padding(.leading, 10)
            
            HStack {
                // Цена
                Text("\(product.discountPrice) ₽")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.leading, 10)
                    .foregroundColor(product.discount > 0 ? Color.red : Color.black)
                
                // Скидочная цена
                Text(product.discount > 0 ? "\(product.formattedPrice) ₽" : " ")
                    .font(.system(size: 12))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black.opacity(0.4))
                    .strikethrough(true, color: .gray)
                    .padding(.top, 8)
            }
            
        }) //: VSTACK
        .shadow(color: Color.black.opacity(0.25), radius: 1, x: 0, y: 0)
    }
}

// MARK: - PREVIEW
struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: products[3])
            .previewLayout(.fixed(width: 200, height: 300))
            .padding()
            .background(colorBackground)
    }
}

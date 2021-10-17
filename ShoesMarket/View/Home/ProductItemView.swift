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
        VStack(alignment: .leading, spacing: 6, content: {
            ZStack {
                // Изображение
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .shadow(color: .black, radius: 20, x: 10, y: 9)

            } //: ZTACK
            .background(Color(red: product.red, green: product.green, blue: product.blue))
            .cornerRadius(12)
            
            // Название
            Text("\(product.name)")
                .font(.title3)
                .fontWeight(.black)
            
            // Цена
            Text(product.formattedPrice)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }) //: VSTACK
    }
}

// MARK: - PREVIEW
struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: products[0])
            .previewLayout(.fixed(width: 200, height: 300))
            .padding()
            .background(colorBackground)
    }
}

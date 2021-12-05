//
//  TitleCategory.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 04.09.2021.
//

import SwiftUI

struct TitleCategory: View {
    
    // MARK: - PROPERTIES
    var title: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            
            Text(title)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
        } //: HSTACK
        .padding(.leading, -25)
//        .padding(.horizontal)
//        .padding(.top, 15)
//        .padding(.bottom, 10)
    }
}

// MARK: - PREVIEW
struct TitleCategory_Previews: PreviewProvider {
    static var previews: some View {
        TitleCategory(title: "Мужская обувь")
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}

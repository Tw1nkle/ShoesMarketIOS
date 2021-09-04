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
                .font(.largeTitle)
                .fontWeight(.heavy)
        } //: HSTACK
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

// MARK: - PREVIEW
struct TitleCategory_Previews: PreviewProvider {
    static var previews: some View {
        TitleCategory(title: "Пол")
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}

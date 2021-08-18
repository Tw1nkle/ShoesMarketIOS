//
//  FeaturedItemView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 14.08.2021.
//

import SwiftUI

struct FeaturedItemView: View {
    
    // MARK: - PROPERTIES
    
    let card: Card
    
    // MARK: - BODY
    
    var body: some View {
        Image(card.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

// MARK: - PREVIEW

struct FeaturedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItemView(card: cards[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}

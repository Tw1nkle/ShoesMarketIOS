//
//  FeaturedTabView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 14.08.2021.
//

import SwiftUI

struct FeaturedTabView: View {
    
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(cards) { card in
                FeaturedItemView(card: card)
                    .padding(.horizontal, 15)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

// MARK: - PREVIEW
struct FeaturedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedTabView()
            .background(Color.gray)
    }
}

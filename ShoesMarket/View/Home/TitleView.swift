//
//  TitleView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 22.08.2021.
//

import SwiftUI

struct TitleView: View {
    
    // MARK: - PROPERTIES
    var title: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Spacer()
        } //: HSTACK
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

// MARK: - PREVIEW
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Новинки")
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}

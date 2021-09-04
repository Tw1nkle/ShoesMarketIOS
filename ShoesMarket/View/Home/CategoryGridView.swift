//
//  CategoryGridView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.08.2021.
//

import SwiftUI

struct CategoryGridView: View {
    
    // MARK: - PROPERTIES
    
    @EnvironmentObject var state: StateModel
    
    // MARK: - BODY
    
    var body: some View {
        LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
            ForEach(categories) { category in
                CategoryItemView(category: category)
            }
        }) //: GRID
        .frame(height: 150)
        .padding(.horizontal, 23)
    }
}

// MARK: - PREVIEW

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView()
            .environmentObject(StateModel())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}

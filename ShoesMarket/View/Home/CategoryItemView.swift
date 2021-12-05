//
//  CategoryItemView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.08.2021.
//

import SwiftUI

struct CategoryItemView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var state: StateModel
    let category: Category

    // MARK: - BODY
    var body: some View {
        // Кнопка категории
        Button(action: {
            if let type = category.type {
                switch type {
                    case .man:
                        state.fullScreenToShow = .man
                    case .woman:
                        state.fullScreenToShow = .woman
                }
            }
        }, label: {
            Image(category.image)
                .resizable()
                .scaledToFit()
                .frame(width: 180)
                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 0)
        }) //: BUTTON
    }
}

// MARK: - PREVIEW
struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: categories[0])
            .environmentObject(StateModel())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}

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
            VStack(alignment: .center, spacing: 6) {
                Image(category.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.black)
                
                Text(category.name.uppercased())
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .font(.title3)
                    .padding(.top, 10)
                
            } //: HSTACK
            .frame(width: 140, height: 110)
            .padding()
            .background(colorBackground.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 6)
            )
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

//
//  CategoryItemView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.08.2021.
//

import SwiftUI

struct CategoryItemView: View {
    
    // MARK: - PROPERTIES
    
    @State private var categoryMenView: Bool = false
    @State private var categoryWomenView: Bool = false
    let category: Category

    // MARK: - BODY
    
    var body: some View {
        Button(action: {
            if category.name == "Мужчины" {
                self.categoryMenView.toggle()
            } else {
                self.categoryWomenView.toggle()
            }
        }, label: {
            VStack(alignment: .center, spacing: 6) {
                Image(category.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.gray)
                
                Text(category.name.uppercased())
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                    .font(.title3)
                    .padding(.top, 10)
                
            } //: HSTACK
            .frame(width: 140, height: 110)
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }) //: BUTTON
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(category: categories[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}

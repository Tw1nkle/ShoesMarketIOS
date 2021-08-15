//
//  FooterView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.08.2021.
//

import SwiftUI

struct FooterView: View {
    
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text("Мы предлагаем самую современную, удобную и легкую обувь на рынке по хорошим ценам.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(2)
            
            Image("logo-white")
                .resizable()
                .renderingMode(.template)
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(.gray)
                .layoutPriority(0)
            
            Text("Авторские права © Shoes Market\nВсе права защищены")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
        } //: VSTACK
        .padding()
        
    }
}

// MARK: - PREVIEW

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}

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
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.5))
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .layoutPriority(2)
                .padding(.bottom, 7)
            
            Image("logo-white")
                .resizable()
                .renderingMode(.template)
                .frame(width: 40.0, height: 40.0)
                .foregroundColor(.gray)
                .layoutPriority(0)
                .padding(.bottom, 7)
            
            Text("Авторские права © Shoes Market\nВсе права защищены")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
        } //: VSTACK
        .padding()
        .padding(.top, 30)
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

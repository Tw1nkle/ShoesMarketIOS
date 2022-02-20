//
//  EmptyCartView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 08.12.2021.
//

import SwiftUI

struct EmptyCartView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var isBack: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            
            Text("В вашей корзине пусто")
                .font(.title3)
                .fontWeight(.heavy)
            
            Text("Начните с просмотра каталога товаров, и вы обязательно найдете то, что вам нужно")
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.5))
                .multilineTextAlignment(.center)
                .font(.system(size: 15))
                .padding(.top, 5)
            
            Button {
                self.isBack = true
            } label: {
                Text("Вернуться к покупкам")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    .padding(.horizontal, 17)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .font(.system(size: 16))
                    .padding(.top, 15)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            
            Spacer()
            
        } //: VSTACK
        .background(colorBackground.ignoresSafeArea())
    }
}

// MARK: - PREVIEW
struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
    }
}

//
//  EmptyCartView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 08.12.2021.
//

import SwiftUI

struct EmptyCartView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isBack: Bool = false
    
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
                    .fontWeight(.bold)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 15)
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

struct EmptyCartView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCartView()
    }
}

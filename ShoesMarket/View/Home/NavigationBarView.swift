//
//  NavigationBarView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 08.08.2021.
//

import SwiftUI

struct NavigationBarView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var state: StateModel
    @EnvironmentObject var shopData: ShopViewModel
    @State private var isAnimated: Bool = false
    
    // MARK: - BODY
    var body: some View {
        HStack {
            // Кнопка поиска
            Button(action: {
                state.fullScreenToShow = .search
            }, label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            })
            
            Spacer()
            
            // Логотип
            LogoView()
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 0, y: isAnimated ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimated.toggle()
                    }
                })
            
            Spacer()
            
            // Кнопка корзины
            Button(action: {
                state.fullScreenToShow = .cart
            }, label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.black)
                    .overlay(
                        Text("\(shopData.cartItems)")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(buttonColor)
                            .clipShape(Circle())
                            .offset(x: 23, y: -17)
                            .opacity(shopData.cartItems != 0 ? 1 : 0)
                    )
            })
        } //: HSTACK
        .padding(.leading)
        .padding(.trailing)
    }
}

// MARK: - PREVIEW
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .environmentObject(ShopViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

//
//  NavigationBarView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 08.08.2021.
//

import SwiftUI

struct NavigationBarView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isAnimated: Bool = false
    @State private var searchView: Bool = false
    @State private var cartView: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        
        HStack {
            Button(action: {
                self.searchView.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(.black)
            }) //: BUTTON
            .fullScreenCover(isPresented: $searchView, content: SearchView.init)
            
            Spacer()
            
            LogoView()
                .opacity(isAnimated ? 1 : 0)
                .offset(x: 0, y: isAnimated ? 0 : -25)
                .onAppear(perform: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimated.toggle()
                    }
                })
            
            Spacer()
            
            Button(action: {
                self.cartView.toggle()
            }, label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.black)
            }) //: BUTTON
            .fullScreenCover(isPresented: $cartView, content: CartView.init)
        } //: HSTACK
        
    }
}

// MARK: - PREVIEW

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

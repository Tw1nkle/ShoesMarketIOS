//
//  CartView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 09.08.2021.
//

import SwiftUI

struct CartView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Cart View")
            
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - PREVIEW
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

//
//  WomanView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 19.08.2021.
//

import SwiftUI

struct WomanView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            Text("Woman View")
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
        
    }
}

// MARK: - PREVIEW

struct WomanView_Previews: PreviewProvider {
    static var previews: some View {
        WomanView()
    }
}

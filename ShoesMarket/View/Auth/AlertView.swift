//
//  AlertView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.08.2021.
//

import SwiftUI

struct AlertView: View {
    
    // MARK: - PROPERTIES
    var message: String
    @Binding var show: Bool
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Text("Внимание!")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(message)
                .foregroundColor(.gray)
            
            Button(action: {
                // Closing popup
                show = false
            }, label: {
                Text("Закрыть")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.yellow)
                    .cornerRadius(15)
            })
            
            // Centering the button
            .frame(alignment: .center)
        }) //: VSTACK
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        
        // Background dim
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
    }
}

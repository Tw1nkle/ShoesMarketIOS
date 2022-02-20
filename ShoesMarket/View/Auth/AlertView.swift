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
                .foregroundColor(.black).opacity(0.5)
            
            Text(message)
                .fontWeight(.medium)
                .foregroundColor(.black).opacity(0.5)
            
            Button(action: {
                show = false
            }, label: {
                Text("Закрыть")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 36)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .font(.system(size: 16))
            })
            .frame(alignment: .center)
        }) //: VSTACK
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.25).ignoresSafeArea())
    }
}

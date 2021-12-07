//
//  ControlView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.12.2021.
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        
        VStack {
            
            // Кнопка закрыть View
            CloseButton()
            
            Spacer()
            
            // Кнопка расположения модели
            ControlButtonBar()
            
        } //: VSTACK
        
    }
}

struct CloseButton: View {
    var body: some View {
        
        HStack {
            
            
            
        } //: HSTACK
        
    }
}

struct ControlButtonBar: View {
    var body: some View {
        
        HStack {
            
            ControlButton(systemIconName: "clock.fill") {
                print("MostRecentlyPlaced button pressed.")
            }
            
            Spacer()
            
            ControlButton(systemIconName: "square.grid.2x2") {
                print("Browse button pressed.")
            }
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3") {
                print("Settings button pressed.")
            }

            
        } //: HSTACK
        .frame(maxWidth: 500)
        .padding(30)
        .background(Color.black.opacity(0.25))
        
    }
}

struct ControlButton: View {
    
    let systemIconName: String
    var action: () -> Void
    
    var body: some View {
        
        Button {
            self.action()
        } label: {
            Image(systemName: systemIconName)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 50, height: 50)
        
    }
}



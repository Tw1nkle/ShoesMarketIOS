//
//  ControlView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.12.2021.
//

import SwiftUI

struct ControlView: View {
    @EnvironmentObject var ps: PlacementSettings
    var body: some View {
        
        VStack {
            
            // Кнопка закрыть окно
            ControlCloseButton()
            
            Spacer()
            
            // Кнопка расположения модели
            VStack(spacing: 16){
                if self.ps.selectedModel != nil{
                    ControlButton(systemIconName: "checkmark.circle.fill", action: {
                        self.ps.confirmedModel = self.ps.selectedModel
                        self.ps.selectedModel = nil
                        print(self.ps.confirmedModel?.name ?? "Nil data")
                    })
                        .padding(.bottom, 80)
                }
//                ControlButtonBar()
            }
            
            
        } //: VSTACK
        
    }
}

struct ControlCloseButton: View {
    @EnvironmentObject var ps: PlacementSettings
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ZStack {
                
                Color.black.opacity(0.25)
                
                Button(action: {
                    print("Closed VR View.")
                    ps.selectedModel = nil
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                
            } //: ZTACK
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
            
        } //: HSTACK
        .padding(.top, 45)
        .padding(.trailing, 20)
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



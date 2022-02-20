//
//  CustomNumberPad.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 05.08.2021.
//

import SwiftUI

struct CustomNumberPad: View {
    
    // MARK: - PROPERTIES
    @Binding var value: String
    var isVerify: Bool
    // Символы для клавиатуры
    var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { reader in
            VStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 15) {
                    ForEach(rows, id: \.self) { value in
                        Button(action: {buttonAction(value: value)}) {
                            ZStack {
                                if value == "delete.left" {
                                    Image(systemName: value)
                                        .font(.title)
                                        .foregroundColor(.black)
                                    
                                } else {
                                    Text(value)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            } //: ZTACK
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        
                        // Отключение кнопки, если ничего не выбрано
                        .disabled(value == "" ? true : false)
                    }
                }
            } //: VSTACK
        } //: READER
        .padding()
    }
    
    // Получение ширины для динамического изменения размера экрана
    func getWidth(frame: CGRect) -> CGFloat {
        let width = frame.width
        
        let actualWidth = width - 40
        
        return actualWidth / 3
    }
    
    // Получение высоты для динамического изменения размера экрана
    func getHeight(frame: CGRect) -> CGFloat {
        let height = frame.height
        
        let actualHeight = height - 40
        
        return actualHeight / 4
    }
    
    func buttonAction(value: String) {
        if value == "delete.left" && self.value != "" {
            self.value.removeLast()
        }
        
        if value != "delete.left" {
            if isVerify {
                if self.value.count < 6 {
                    self.value.append(value)
                }
            } else {
                self.value.append(value)
            }
        }
    }
}

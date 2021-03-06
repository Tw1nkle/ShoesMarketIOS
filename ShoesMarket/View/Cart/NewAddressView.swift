//
//  NewAddressView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.12.2021.
//

import SwiftUI

struct NewAddressView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @State private var street: String = ""
    @State private var apartment: String = ""
    @State private var entrance: String = ""
    @State private var floor: String = ""
    @Binding var deliveryType: DeliveryType?
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text("Новый адрес")
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.top, 30)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity, alignment: .center)
            
            TextField(
                "Населенный пункт, улица, дом*",
                text: $street
            )
            .disableAutocorrection(true)
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .padding(.bottom, 5)
            
            TextField(
                "Квартира/офис",
                text: $apartment
            )
            .disableAutocorrection(true)
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .padding(.bottom, 5)
            
            HStack {
                TextField(
                    "Подъезд",
                    text: $entrance
                )
                .disableAutocorrection(true)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                
                TextField(
                    "Этаж",
                    text: $floor
                )
                .disableAutocorrection(true)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            } //: HSTACK
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    deliveryType = .address
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Сохранить")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(10)
            }
            .padding(.bottom)
        } //: VSTACK
        .padding(.leading)
        .padding(.trailing)
    }
}

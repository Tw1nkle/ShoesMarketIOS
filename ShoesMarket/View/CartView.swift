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
    @EnvironmentObject var shopData: ShopViewModel
    @EnvironmentObject var state: StateModel
    @State private var isBack = false
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isBack = true
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.title)
                        .foregroundColor(.black)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                })
                .padding()
                
                TitleCategory(title: "Корзина")
                
                Spacer()
            } //: HSTACK
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(shopData.cartProducts) { product in
                        Text(product.product.name)
                    }
                }
            } //: SCROLL
            
            // Bottom View
            VStack {
                HStack {
                    
                    Text("Итого")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Calculating total price
                    Text(shopData.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                } //: HSTACK
                .padding([.top, .horizontal])
                
                Button(action: {}) {
                    Text("Оформить заказ")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                }
                
            } //: VSTACK
            .background(Color.white)
            
        } //: VSTACK
    }
}

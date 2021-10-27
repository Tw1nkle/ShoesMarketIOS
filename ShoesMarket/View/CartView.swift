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
    @StateObject var modelData = ShopViewModel()
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
                
                // Название категории
                TitleCategory(title: "Корзина")
                
                Spacer()
            } //: HSTACK
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(modelData.cardRealm) { card in
                        HStack(spacing: 15) {
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130, height: 130)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Кроссовки \(card.name)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Text("Размер: \(card.size) RU")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 15) {
                                    
                                    Text(shopData.getPrice(value: card.price))
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {}) {
                                        Image(systemName: "minus")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.black)
                                    }
                                } //: HSTACK
                            } //: VSTACK
                        } //: HSTACK
                    }
                } //: LAZYVSTACK
            } //: SCROLL
            
            VStack {
                HStack {
                    
                    Text("Итого")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Итоговая цена
                    Text(shopData.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                } //: HSTACK
                .padding([.top, .horizontal])
                
                Button(action: {}) {
                    Text("Оформить заказ")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow)
                        .cornerRadius(18)
                }
                .padding()
                
            } //: VSTACK
            .background(Color.white)
            
        } //: VSTACK
    }
}

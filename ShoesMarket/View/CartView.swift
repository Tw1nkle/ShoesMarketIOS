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
    
    // Промокод
    @State private var promocode = ""
    
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
                    .padding(.leading, -30)
                
                Spacer()
            } //: HSTACK
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(modelData.cardRealm) { card in
                        HStack(spacing: 15) {
                            Image(card.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160, height: 110)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Кроссовки \(card.name)")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Text("Размер: \(card.size)")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                
                                HStack(spacing: 15) {
                                    
                                    Text("\(shopData.getPrice(value: card.price)) ₽")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {modelData.deleteProduct(object: card)}) {
                                        Image(systemName: "trash")
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.black.opacity(0.5))
                                    }
                                } //: HSTACK
                            } //: VSTACK
                        } //: HSTACK

                        Divider()
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        
                    }
                } //: LAZYVSTACK
            } //: SCROLL
            .padding()
            
            VStack {
                
                HStack {
                    
                    TextField("Промокод", text: $promocode)
                    
                    Button(action: {}) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.black.opacity(0.3))
                            .frame(width: 20, height: 20)
                    }
                    .padding(5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)

                    
                }
                .padding(.top, 10)
                .padding(.leading)
                .padding(.trailing)
                
                Divider()
                    .padding(.top, 5)
                    .padding(.leading)
                    .padding(.trailing)
                
                HStack {
                    
                    Text("Итого к оплате")
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Итоговая цена
                    Text("\(shopData.calculateTotalPrice()) ₽")
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                } //: HSTACK
                .padding([.top, .horizontal])
                
                Button(action: {}) {
                    Text("Оформить заказ на \(shopData.calculateTotalPrice()) ₽")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .padding(.leading, 60)
                        .padding(.trailing, 60)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .font(.system(size: 16))
                }
                .padding()
                
            } //: VSTACK
//            .background(Color.white.ignoresSafeArea(edges: .bottom))
            
        } //: VSTACK
        .background(colorBackground.ignoresSafeArea())
    }
}

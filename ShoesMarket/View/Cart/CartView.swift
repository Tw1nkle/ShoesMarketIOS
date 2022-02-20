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
    @State private var showOrderCartView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
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
            
            if shopData.cardRealm.isEmpty {
                EmptyCartView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(modelData.cardRealm) { card in
                            if !card.isInvalidated{
                                HStack(spacing: 15) {
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 160, height: 100)
                                        .cornerRadius(15)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Кроссовки \(card.name)")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                        
                                        Text("Артикул: \(card.code)")
                                            .font(.system(size: 14))
                                        
                                        Text("Цвет: \(card.color)")
                                            .font(.system(size: 14))
                                        
                                        Text("Размер: \(card.size)")
                                            .font(.system(size: 14))
                                        
                                        HStack() {
                                            Text("\(shopData.getPrice(value: card.price)) ₽")
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            // Скидка
                                            Text("\(card.formattedPrice) ₽")
                                                .font(.system(size: 11))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.black.opacity(0.4))
                                                .strikethrough(true, color: .gray)
                                                .padding(.top, -3)
                                            
                                            Spacer(minLength: 0)
                                            
                                            Button(action: {
                                                withAnimation {
                                                    modelData.deleteProduct(object: card)
                                                }
                                            })
                                            {
                                                Image(systemName: "trash")
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color.black.opacity(0.5))
                                            }
                                        } //: HSTACK
                                        .padding(.top, -3)
                                    } //: VSTACK
                                } //: HSTACK
                                
                                Divider()
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                            }
                        }
                    } //: LAZYVSTACK
                } //: SCROLL
                .padding([.leading, .trailing, .top])
                
                VStack {
                    Divider()
                        .padding(.leading)
                        .padding(.trailing)
                    
                    HStack {
                        Text("Количество товаров")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Text("\(shopData.cardRealm.count) шт.")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                    } //: HSTACK
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    HStack {
                        Text("Товары на сумму")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Text("\(shopData.calculateTotalPrice()) ₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                    } //: HSTACK
                    .padding(.horizontal)
                    .padding(.top, 3)
                    
                    HStack {
                        Text("Скидка")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(discountColor)
                        
                        Spacer(minLength: 0)
                        
                        Text("\(shopData.summOfDiscount()) ₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(discountColor)
                    } //: HSTACK
                    .padding(.horizontal)
                    .padding(.top, 3)
                    
                    HStack {
                        Text("Итого к оплате")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        // Итоговая цена
                        Text("\(shopData.calculatePrice()) ₽")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                    } //: HSTACK
                    .padding(.horizontal)
                    .padding(.top, 3)
                    
                    Button(action: {
                        showOrderCartView.toggle()
                    }) {
                        Text("Перейти к оформлению заказа")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .background(buttonColor)
                            .cornerRadius(10)
                            .font(.system(size: 16))
                    }
                    .padding()
                    .fullScreenCover(isPresented: $showOrderCartView) {
                        OrderCartView()
                    }
                } //: VSTACK
                .background(colorBackground)
            }
        } //: VSTACK
        .background(colorBackground.ignoresSafeArea())
    }
}

//
//  OrderCartView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 14.12.2021.
//

import SwiftUI

struct OrderCartView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @StateObject var modelData = ShopViewModel()
    @State private var isBack = false
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var showNewAddressView: Bool = false
    @State private var showDeliveryTermsView: Bool = false
    @State private var showReternOrderView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
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
                TitleCategory(title: "Оформление заказа")
                    .padding(.leading, -25)
                
                Spacer()
            } //: HSTACK
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Контактные данные")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.bottom, 15)
                    
                    TextField(
                        "ФИО*",
                        text: $fullName
                    )
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding(.bottom, 5)
                    
                    TextField(
                        "Email",
                        text: $email
                    )
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Доставка")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 15)
                    
                    Button {
                        showNewAddressView.toggle()
                    } label: {
                        Text("Адресная доставка домой/в офис")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.20), lineWidth: 1)
                    )
                    .padding(.bottom, 5)
                    
                    Button {} label: {
                        Text("В постамат/пункт выдачи")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black.opacity(0.20), lineWidth: 1)
                    )
                    .padding(.bottom, 5)
                    
                    HStack(spacing: 5) {
                        Text("Условия")
                        
                        Button {
                            showDeliveryTermsView.toggle()
                        } label: {
                            Text("доставки")
                        }
                        
                        Text("и")
                        
                        Button {
                            showReternOrderView.toggle()
                        } label: {
                            Text("возврата")
                        }
                    } //: HSTACK
                    .font(.system(size: 14))
                    
                    Text("Оплата")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 15)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Apple Pay")
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(buttonColor)
                                    .frame(width: 25, height: 25)
                                
                                Circle()
                                    .foregroundColor(Color.white)
                                    .frame(width: 15, height: 15)
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Банковской картой")
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.black.opacity(0.05))
                                    .frame(width: 25, height: 25)
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("При получении наличными/картой")
                            
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.black.opacity(0.05))
                                    .frame(width: 25, height: 25)
                            }
                        }
                    } //: VSTACK
                }
                
                VStack {
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Количество товаров")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Text("1шт.")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                    } //: HSTACK
                    .padding(.top, 10)
                    
                    HStack {
                        
                        Text("Товары на сумму")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Text("1 231 ₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                    } //: HSTACK
                    .padding(.top, 3)
                    
                    HStack {
                        
                        Text("Скидка")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(discountColor)
                        
                        Spacer(minLength: 0)
                        
                        Text("-3 897₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(discountColor)
                        
                    } //: HSTACK
                    .padding(.top, 3)
                    
                    HStack {
                        
                        Text("Итого к оплате")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        // Итоговая цена
                        Text("1 123 ₽")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                        
                    } //: HSTACK
                    .padding(.top, 3)
                    
                    Button(action: {}) {
                        Text("Оформить заказ на 2 123 ₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(10)
                    }
                    .disabled(true)
                    
                } //: VSTACK
                .background(colorBackground)
            } //: SCROLL
            .padding(.leading)
            .padding(.trailing)
            .sheet(isPresented: $showNewAddressView) {
                NewAddressView()
            }
            .sheet(isPresented: $showDeliveryTermsView) {
                DeliveryTermsView()
            }
            .sheet(isPresented: $showReternOrderView) {
                ReternOrderView()
            }
        } //: VSTACK
        .background(colorBackground.ignoresSafeArea())
    }
}

// MARK: - PREVIEW
struct OrderCartView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCartView()
    }
}

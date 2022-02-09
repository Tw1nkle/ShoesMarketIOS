//
//  OrderCartView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 14.12.2021.
//

import SwiftUI
    
    //MARK: - Payment Type

enum PaymentType: String, CaseIterable{
    case applePay = "Apple Pay"
    case card = "Банковской картой"
    case uponReceipt = "При получении наличными/картой"
}

    //MARK: - Payment Type

enum DeliveryType: String, CaseIterable{
    case address = "Адресная доставка домой/в офис"
    case pointOfIssue = "В постамат/пункт выдачи"
}

struct OrderCartView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @State private var isBack = false
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var showNewAddressView: Bool = false
    @State private var showDeliveryTermsView: Bool = false
    @State private var showReternOrderView: Bool = false
    @State private var paymentType: PaymentType = .applePay
    @State private var deliveryType: DeliveryType? = nil
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
                    
                  
                    
                    VStack{
                        ForEach(DeliveryType.allCases, id: \.self){type in
                            Button {
                                if type == .address{
                                    showNewAddressView.toggle()
                                } else {
                                    withAnimation {
                                        deliveryType = .pointOfIssue
                                    }
                                }
                            } label: {
                                Text(type.rawValue)
                                    .font(.system(size: 16))
                                    .foregroundColor(deliveryType == type ? Color.white : Color.black)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(deliveryType == type ? Color("ButtonColor") : Color( UIColor.systemBackground))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(deliveryType == type ? Color("ButtonColor") : Color.black.opacity(0.20), lineWidth: 1)
                                    )
                                    .padding(.bottom, 5)
                                    .padding(.horizontal, 1)
                            }
                          
                        }
                    }
                    
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
                    
                   
                       
                    VStack(spacing: 0){
                        ForEach(PaymentType.allCases, id: \.self){type in
                            VStack(alignment: .leading, spacing: 0) {
                                Spacer(minLength: 0)
                            HStack {
                                Text(type.rawValue)
                                
                                Spacer()
                                
                                ZStack {
                                    if paymentType == type{
                                        Circle()
                                            .foregroundColor(buttonColor)
                                            .frame(width: 25, height: 25)
                                        
                                        Circle()
                                            .foregroundColor(Color.white)
                                            .frame(width: 15, height: 15)
                                    } else {
                                    Circle()
                                        .foregroundColor(Color.black.opacity(0.05))
                                        .frame(width: 25, height: 25)
                                    }
                                }
                            }
                            Spacer(minLength: 0)
                                if type != PaymentType.allCases.last{
                                    Divider()
                                }
                            }
                            .contentShape(Rectangle())
                            .frame(height: 52)
                            .onTapGesture {
                                withAnimation {
                                    paymentType = type
                                }
                            }
                        }
                    }
                    .padding(.bottom, 13)
                    //: VSTACK
                }
                
                VStack {
                    
                    Divider()
                    
                    HStack {
                        
                        Text("Количество товаров")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer(minLength: 0)
                        
                        Text("\(shopData.cardRealm.count) шт.")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                    } //: HSTACK
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
                    .padding(.top, 3)
                    
                    Button(action: {}) {
                        Text("Оформить заказ на \(shopData.calculatePrice()) ₽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(shopData.isDisabled(name: fullName, email: email, deliveryType: deliveryType) ? .black : .white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(shopData.isDisabled(name: fullName, email: email, deliveryType: deliveryType) ? Color.black.opacity(0.06) : Color("ButtonColor"))
                            .cornerRadius(10)
                    }
                    .disabled(shopData.isDisabled(name: fullName, email: email, deliveryType: deliveryType))
                    .padding(.bottom)
                } //: VSTACK
                .background(colorBackground)
            } //: SCROLL
            .padding(.leading)
            .padding(.trailing)
            .sheet(isPresented: $showNewAddressView) {
                NewAddressView(deliveryType: $deliveryType)
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

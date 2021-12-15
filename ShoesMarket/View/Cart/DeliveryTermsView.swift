//
//  DeliveryTermsView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.12.2021.
//

import SwiftUI

struct DeliveryTermsView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading) {
                
                Text("Условия доставки")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("Получайте свои заказы бесплатно в любой точки России!")
                    .padding(.bottom, 10)
                
                Text("Наша задача - доставлять ваши заказы") + Text(" быстро и максимально удобно").bold() + Text(", именно поэтому мы не ограничиваем вас в выборе способа доставки.")
                
                Text("Вы можете выбрать:")
                    .padding(.bottom, 20)
                
                HStack {
                    Text("—")
                        .padding(.trailing, 15)
                    
                    Text("адресную доставку домой или в офис служебной доставки Shoes-Market или сторонней курьерской службой,")
                } //: HSTACK
                
                HStack {
                    Text("—")
                        .padding(.trailing, 15)
                    
                    Text("доставку в партнерский постамат или пункт выдачи.")
                } //: HSTACK
                .padding(.bottom, 20)
                
                Text("Служба доставки Shoes-Market")
                    .padding(.bottom, 15)
                
                HStack {
                    Text(String("\u{25CF}"))
                        .padding(.trailing, 15)
                    
                    Text("Доставка собственной службой доставки производится, начиная со дня, следующего за днем оформления заказа:")
                } //: HSTACK
                .padding(.bottom, 10)
                
                Text("по Москве, Московской области и Санкт-Петербургу;")
                    .padding(.bottom, 10)
                    .padding(.leading, 64)
                
                Text("с 9.00 до 21.00 по Москве в пределах МКАД.")
                    .padding(.bottom, 10)
                    .padding(.leading, 64)
                
            } //: VSTACK
            
            VStack {
                
                HStack {
                    Text(String("\u{25CF}"))
                        .padding(.trailing, 15)
                    
                    Text("Доставка, осуществляемая собственной службой доставки, является бесплатной и включает весь сервис, предоставляемый компанией Shoes-Market.") + Text("Доставка бесплатна даже в случае отказа от своего заказа").bold()
                } //: HSTACK
                .padding(.bottom, 20)
                
                HStack {
                    Text(String("\u{25CF}"))
                        .padding(.trailing, 15)
                    
                    Text("Компания Shoes-Market оставляет за собой право отказать клиенту в доставке товаров домой/в офис Собственной службой доставки в случае некорректного поведения клиента.")
                } //: HSTACK
                .padding(.bottom, 10)
                
                HStack {
                    Text(String("\u{25CF}"))
                        .padding(.trailing, 15)
                    
                    Text("Возможные способы оплаты мобильному продавцу: наличными или банковской картой.")
                } //: HSTACK
                .padding(.trailing)
                .padding(.bottom, 10)
                
            } //: VSTACK
            
        } //: SCROLL
        .padding(.leading)
        .padding(.trailing)
    }
}

// MARK: - PREVIEW
struct DeliveryTermsView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryTermsView()
    }
}

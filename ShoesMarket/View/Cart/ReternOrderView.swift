//
//  ReternOrderView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.12.2021.
//

import SwiftUI

struct ReternOrderView: View {
    
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text("Условия возврата")
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.top, 30)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Возврат товара")
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Text("Вы можете вернуть новый неношеный товар в течение ") + Text("30 календарных дней").bold() + Text(", не считая дня покупки. В иных случаях, предусмотренных законодательно, срок может быть увеличен.")
            
            Text("Куда вернуть товар")
                .font(.system(size: 18))
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Text("Если товар был доставлен собственной курьерской службой, вы можете вернуть его в любой постамат или пункт выдачи товаров.")
                .padding(.bottom, 10)
            
            Text("Обращаем внимание, что вернуть можно только товары, приобретенные на территории РФ. Товары, приобретенные за пределами РФ, вернуть товар нельзя.")
            
            Spacer()
        } //: VSTACK
        .padding(.trailing)
        .padding(.leading)
    }
}

// MARK: - PREVIEW
struct ReternOrderView_Previews: PreviewProvider {
    static var previews: some View {
        ReternOrderView()
    }
}

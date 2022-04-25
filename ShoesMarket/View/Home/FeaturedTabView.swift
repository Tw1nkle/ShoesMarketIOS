//
//  FeaturedTabView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 14.08.2021.
//

import SwiftUI
import RealmSwift

struct FeaturedTabView: View {
    
    // MARK: - PROPERTIES
    
    @State var selection: Int = 1
    @State var counter = 0
    @State var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $selection) {
            ForEach(cards, id: \.id) { card in
                FeaturedItemView(card: card)
                    .tag(card.id)
                    .padding(.horizontal, 15)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onReceive(timer) { out in
            
            // Каждые две секунды меняется состояние selection -> TabView перелистывается
            if counter == 2 {
                withAnimation {
                    // Если id последнего элемента массива не равно нашей selection, то +1
                    if selection != cards.last?.id {
                        selection += 1
                    } else {
                        
                        // Если id у него последнего элемента массива равно нашей selection,
                        // то задаем значение первого элемента массива
                        selection = cards.first?.id ?? 1
                    }
                }
                // Обновляем значение counter, чтобы сбросился таймер
                self.counter = 0
            } else {
                // Плюсуем в counter каждую секунду значение 1
                self.counter += 1
            }
        }
    }

}

// MARK: - PREVIEW
struct FeaturedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedTabView()
            .background(Color.gray)
    }
}

//
//  StateModel.swift
//  ShoesMarket
//
//  Created by  g01dt00th on 15.08.2021.
//

import SwiftUI

enum ScreenToShow: String, Identifiable, View {
    var id: String {
        self.rawValue
    }
    case search
    case cart
    case man
    case woman
    
    var body: some View {
        switch self {
            case .search:
                SearchView()
            case .cart:
                CartView()
            case .man:
                ManView()
            case .woman:
                WomanView()
        }
    }
}

final class StateModel: ObservableObject {
    @Published var fullScreenToShow: ScreenToShow?
}

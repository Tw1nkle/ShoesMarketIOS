//
//  ShopViewModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var showCart: Bool = false
    @Published var selectedSize: String = ""
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}

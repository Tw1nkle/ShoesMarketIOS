//
//  Cart.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 19.09.2021.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var product: Product
    var quantity: Int 
    
}

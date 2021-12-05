//
//  ProductModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 22.08.2021.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let gender: String
    let price: Int
    let color: String
    let code: String
    let discount: Int
    let sizes: [String]
    
    // Для идентификации товара, есть ли он в корзине
    var isAdded: Bool? = false
    
    var formattedPrice: Int { return price }
    
    var discountPrice: Int { return price - (price * discount) / 100 }
}

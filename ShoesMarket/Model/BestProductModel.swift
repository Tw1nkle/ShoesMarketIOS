//
//  BestProductModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 04.12.2021.
//

import Foundation

struct BestProduct: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let gender: String
    let price: Int
    let code: String
    let discount: Int
    let sizes: [String]
    
    // Для идентификации товара, есть ли он в корзине
    var isAdded: Bool? = false
    
    var formattedPrice: String { return "\(price) ₽" }
}

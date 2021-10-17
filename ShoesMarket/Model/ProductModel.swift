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
    let description: String
    let color: [Double]
    let sizes: [String]
    
    // Для идентификации товара, есть ли он в корзине
    var isAdded: Bool? = false
    
    var red: Double { return color[0] }
    var green: Double { return color[1] }
    var blue: Double { return color[2] }
    
    var formattedPrice: String { return "\(price) руб." }
}

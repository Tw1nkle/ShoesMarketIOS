//
//  CategoryModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.08.2021.
//

import Foundation

enum CategoryType: String {
    case man = "Мужчины"
    case woman = "Женщины"
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
    
    var type: CategoryType? {
        CategoryType(rawValue: name)
    }
}

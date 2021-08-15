//
//  CategoryModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 15.08.2021.
//

import Foundation

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}

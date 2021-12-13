//
//  SizeModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 12.12.2021.
//

import Foundation

struct Size: Codable, Identifiable {
    let id: Int
    let globalSize: String
    let centimeters: String
}

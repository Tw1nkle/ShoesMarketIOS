//
//  Constant.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.08.2021.
//

import SwiftUI

// DATA

let cards: [Card] = Bundle.main.decode("cards.json")
let categories: [Category] = Bundle.main.decode("category.json")
//let products: [Product] = Bundle.main.decode("product.json")
//let sampleProduct: Product = products[0]

// COLOR

let colorBackground: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.systemGray4)

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}

var gridLayoutVertical: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

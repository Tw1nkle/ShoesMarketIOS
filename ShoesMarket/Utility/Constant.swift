//
//  Constant.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 07.08.2021.
//

import SwiftUI

// Данные
let cards: [Card] = Bundle.main.decode("cards.json")
let categories: [Category] = Bundle.main.decode("category.json")
let products: [Product] = Bundle.main.decode("product.json")
let bestProducts: [BestProduct] = Bundle.main.decode("bestProducts.json")
let sampleProduct: Product = products[3]

// Цвета
let colorBackground: Color = Color("ColorBackground")
let buttonColor: Color = Color("ButtonColor")
let darkenColor: Color = Color("DarkenButtonColor")
let discountColor: Color = Color("DiscountColor")
let colorGray: Color = Color(UIColor.systemGray4)

// Размер
let columnSpacing: CGFloat = 15
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}

let columnSize = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

var gridLayoutVertical: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

var gridLayoutHorizontal: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 8)
}

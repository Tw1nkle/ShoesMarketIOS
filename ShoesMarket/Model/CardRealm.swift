//
//  CardRealm.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 26.09.2021.
//

import SwiftUI
import RealmSwift

class CardRealm: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var price = 0
    @objc dynamic var size = ""
}

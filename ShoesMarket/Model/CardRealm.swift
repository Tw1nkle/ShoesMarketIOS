//
//  CardRealm.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 26.09.2021.
//

import SwiftUI
import RealmSwift

class CardRealm: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var price = 0
    @objc dynamic var size = ""
    @objc dynamic var color = ""
    @objc dynamic var code = ""
    @objc dynamic var formattedPrice = 0
    @objc dynamic var items = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

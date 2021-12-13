//
//  ShopViewModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI
import RealmSwift

class ShopViewModel: ObservableObject {
    
    // Выбранный продукт
    @Published var showCart: Bool = false
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
    
    // Анимация
    @Published var startAnimation = false
    @Published var shoeAnimation = false
    @Published var showBag = false
    @Published var saveCart = false
    @Published var addItemToCart = false
    @Published var endAnimation = false
    
    // Количество элементов
    @Published var cartItems = 0
    
    // Поиск
    @Published var searchQuery = ""
    
    // Данные о товаре
    @Published var products: [Product] = []
    @Published var productName: String = ""
    @Published var productImage: String = ""
    @Published var productPrice: Int = 0
    @Published var selectedSize: String = ""
    
    // Получение данных
    @Published var cardRealm: [CardRealm] = []
    
    init() {
        fetchData()
    }
    
    // Данные корзины
    @Published var cartProducts: [Cart] = []
    
    // Анимация
    func performAnimations() {
        withAnimation(.easeOut(duration: 0.8)) {
            shoeAnimation.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut) {
                self.showBag.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.saveCart.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addItemToCart.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }
    
    // Сброс данных
    func resetAll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            withAnimation {
                showCart = false
            }
            
            startAnimation = false
            endAnimation = false
            selectedSize = ""
            addItemToCart = false
            showBag = false
            shoeAnimation = false
            saveCart = false
        }
    }
    
    // Получение данных
    func fetchData() {
        
        guard let dbRef = try? Realm() else {return}
        
        let results = dbRef.objects(CardRealm.self)
        
        // Отображение результатов
        self.cardRealm = results.compactMap({ (card) -> CardRealm? in
            return card
        })
        
    }
    
    // Добавление данных в Realm
    func addData() {
        
        let card = CardRealm()
        card.name = productName
        card.image = productImage
        card.price = productPrice
        card.size = selectedSize
        
        // Получение справки
        guard let dbRef = try? Realm() else {return}
        
        // Запись данных
        try? dbRef.write {
            dbRef.add(card)
            fetchData()
            cartItems += 1
        }
        
    }
    
    // Добавление товара в корзину
    func addToCart(product: Product) {

        // Проверка товара, есть ли он в корзине
        self.products[getIndex(product: product, isCartIndex: false)].isAdded = !product.isAdded!

        if product.isAdded! {

            // Удаление из списка
            self.cartProducts.remove(at: getIndex(product: product, isCartIndex: true))
            return
            
        }
        
        self.cartProducts.append(Cart(product: product, quantity: 1))

    }
    
    // Получение индекса товара
    func getIndex(product: Product, isCartIndex: Bool) -> Int {

        let index = self.products.firstIndex { (item1) -> Bool in
            return product.id == item1.id
        } ?? 0

        let cartIndex = self.cartProducts.firstIndex { (item1) -> Bool in
            return product.id == item1.product.id
        } ?? 0

        return isCartIndex ? cartIndex : index

    }
    
    // Подсчет итоговой суммы
    func calculateTotalPrice() -> Int {
        
        var price: Int = 0
        cardRealm.forEach { (item) in
            price += item.price
        }
        
        return price
    }
    
    // Получение цены
    func getPrice(value: Int) -> Int {

        return value
        
    }
    
    // Удаление модели
    func deleteProduct(object: CardRealm) {
        let realm = try! Realm()
        let deleteItem = realm.objects(CardRealm.self).filter("id == %@", object.id)
        try! realm.write {
            realm.delete(deleteItem)
            fetchData()
            cartItems -= 1
        }
    }
    
}

//
//  ShopViewModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    
    // Product selection
    @Published var showCart: Bool = false
    @Published var selectedSize: String = ""
    
    // Product display
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
    
    // Animation properties
    @Published var startAnimation = false
    @Published var shoeAnimation = false
    @Published var showBag = false
    @Published var saveCart = false
    @Published var addItemToCart = false
    @Published var endAnimation = false
    
    // Cart items
    @Published var cartItems = 0
    
    // Search
    @Published var searchQuery = ""
    
    // Product data
    @Published var products: [Product] = []
    
    // Cart data
    @Published var cartProducts: [Cart] = []
    
    // Performing animations
    func performAnimations() {
        withAnimation(.easeOut(duration: 0.8)) {
            shoeAnimation.toggle()
        }
        
        // Chain animations
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
        
        // To start animation before the shoe comes to cart
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.addItemToCart.toggle()
        }
        
        // End animation will start at 1.25
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.endAnimation.toggle()
            }
        }
    }
    
    // Reset
    func resetAll() {
        // Giving some time to finish animations
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
            cartItems += 1
        }
    }
    
    func addToCart(product: Product) {

        // Checking it is added

        self.products[getIndex(product: product, isCartIndex: false)].isAdded = !product.isAdded!

        if product.isAdded! {

            // Removing from list
            self.cartProducts.remove(at: getIndex(product: product, isCartIndex: true))
            return
            
        }
        
        // Else adding

        self.cartProducts.append(Cart(product: product, quantity: 1))

    }
    
    func getIndex(product: Product, isCartIndex: Bool) -> Int {

        let index = self.products.firstIndex { (item1) -> Bool in
            return product.id == item1.id
        } ?? 0

        let cartIndex = self.cartProducts.firstIndex { (item1) -> Bool in
            return product.id == item1.product.id
        } ?? 0

        return isCartIndex ? cartIndex : index

    }
    
    func calculateTotalPrice() -> String {
        
        var price: Float = 0
        cartProducts.forEach { (item) in
            price += Float(item.quantity) * Float(item.product.price)
            
        }
        
        return "\(price) руб."
    }
    
}

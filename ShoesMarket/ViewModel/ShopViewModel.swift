//
//  ShopViewModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var showCart: Bool = false
    @Published var selectedSize: String = ""
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
                showCart.toggle()
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
    
}

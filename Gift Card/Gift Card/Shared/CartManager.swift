//
//  CartManager.swift
//  Gift Card
//
//

import Foundation

// CartManager - Responsible for managing cart
//               Can add items to cart
//               Can remove items from cart
//               Can check if cart has an item
//               Can delete all items from cart
//               Based on singleton pattern
public class CartManager {
    
    private init() {}
    
    static let shared = CartManager()
    
    private(set) var cards = [GiftCardModel]()
    
    // check if cart has given card
    func isCardAlreadyAdded(_ card: GiftCardModel) -> Bool {
        cards.contains { $0 == card}
    }
    
    // add given card to cart
    func addToCart(_ card: GiftCardModel) {
        cards.append(card)
    }
    
    // remove card from cart
    func removeFromCart(_ card: GiftCardModel) {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
        }
    }
    
    // clear all cards from cart
    func clearCart() {
        cards.removeAll()
    }
}

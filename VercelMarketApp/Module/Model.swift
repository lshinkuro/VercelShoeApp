//
//  Model.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import Foundation

struct Shoe : Hashable{
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
}


class CartService {
    static let shared = CartService()

    private init() {}

    private var cartItems: [Shoe: Int] = [:]

    func addToCart(shoe: Shoe) {
        cartItems[shoe, default: 0] += 1
    }

    func removeFromCart(shoe: Shoe) {
        guard let count = cartItems[shoe], count > 0 else { return }
        if count == 1 {
            cartItems.removeValue(forKey: shoe)
        } else {
            cartItems[shoe] = count - 1
        }
    }

    func getCartItems() -> [(shoe: Shoe, quantity: Int)] {
        return cartItems.map { ($0.key, $0.value) }
    }

    func clearCart() {
        cartItems.removeAll()
    }

    func getTotalQuantity() -> Int {
        return cartItems.values.reduce(0, +)
    }
}

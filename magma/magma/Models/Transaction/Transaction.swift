//
//  Transaction.swift
//  magma
//
//  Created by Justin Wilkin on 22/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class Transaction {
    // MARK: - Properties
    private var card: Card
    private var amount: Double
    private var currency: String
    private var location: String
    private var date: String
    private var receiver: String
    
    // MARK: -
    init (card: Card, amount: Double, currency: String, location: String, date: String, receiver: String) {
        self.card = card
        self.amount = amount
        self.currency = currency
        self.location = location
        self.date = date
        self.receiver = receiver
    }
    
    // MARK: - Getters
    public func getCard() -> Card {
        return card
    }
    
    public func getAmount() -> Double {
        return amount
    }
    
    public func getCurrency() -> String {
        return currency
    }
    
    public func getLocation() -> String {
        return location
    }
    
    public func getDate() -> String {
        return date
    }
    
    public func getReceiver() -> String {
        return receiver
    }
}

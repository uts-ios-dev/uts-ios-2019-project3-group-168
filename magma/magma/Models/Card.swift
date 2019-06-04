//
//  Card.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class Card {
    // MARK: - Properties
    private var id: Int
    private var name: String
    private var number: String
    private var cvc: String
    private var status: Bool
    private var style: CardStyle
    private var expiry: String
    
    // MARK: - Constructors
    init () {
        // Stub up a dummy card for now
        self.id = 0
        self.name = "John Clarke"
        self.number = String(Util.getRandomIntInclusive(start: 1000000000000000, end: 9999999999999999))
        self.cvc = String(Util.getRandomIntInclusive(start: 0, end: 999))
        self.status = true
        self.style = CardStyle()
        self.expiry = "10/19"
    }
    
    init (id: Int, name: String, number: String, cvc: String, status: Bool, expiry: String) {
        self.id = id
        self.name = name
        self.number = number
        self.cvc = cvc
        self.status = status
        self.style = CardStyle()
        self.expiry = expiry
    }
    
    // MARK: - Class Methods
    private func maskNumber() -> String {
        var maskedNumber = ""
        for (i, char) in number.enumerated() {
            // Add a space for formatting
            if (i % 4 == 0) {
                maskedNumber += " "
            }
            
            // Replace the first 12 digits with a mask
            if (i < number.count - 4) {
                maskedNumber += "*"
            } else {
                maskedNumber += String(char)
            }
        }
        
        return maskedNumber
    }
    
    // MARK: - Access
    public func getName() -> String {
        return name
    }
    
    public func getNumber() -> String {
        return maskNumber()
    }
    
    public func getUnMaskedNumber() -> String {
        var numberUnmasked = ""
        for (i, char) in number.enumerated() {
            // Add a space for formatting
            if (i % 4 == 0) {
                numberUnmasked += " "
            }
            
            numberUnmasked += String(char)
        }
        
        return numberUnmasked
    }
    
    public func getCvc() -> String {
        return cvc
    }
    
    public func getStatus() -> Bool {
        return status
    }
    
    public func getStyle() -> CardStyle {
        return style
    }
    
    public func getExpiry() -> String {
        return expiry
    }
}

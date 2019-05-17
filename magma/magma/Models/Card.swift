//
//  Card.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class Card {
    private var id: Int
    private var name: String
    private var number: String
    private var cvc: String
    private var status: Bool
    
    init () {
        self.id = 0
        self.name = ""
        self.number = "XXXXXXXXXXXXXXXX"
        self.cvc = "XXX"
        self.status = false
    }
    
    init (id: Int, name: String, number: String, cvc: String, status: Bool) {
        self.id = id
        self.name = name
        self.number = number
        self.cvc = cvc
        self.status = status
    }
    
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
    
    // MARK: - Retrieval
    public func getName() -> String {
        return name
    }
    
    public func getNumber() -> String {
        return maskNumber()
    }
    public func getCvc() -> String {
        return ""
    }
    
    public func getStatus() -> Bool {
        return status
    }
}

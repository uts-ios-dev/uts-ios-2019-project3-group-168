//
//  CardManager.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class CardManager {
    var cards: [Card]
    
    init () {
        self.cards = []
    }
    
    // Retrieves our current user's listed cards
    public func loadCards() {
        // Request cards from backend and load them
    }
    
    // Adds a new card to our wallet
    public func newCard() {
        
    }
    
    // Removes a card from our wallet
    public func removeCard(id: Int) {
        
    }
    
    // Deactivates a card in our wallet
    public func deactivateCard(id: Int) {
        
    }
    
    // Return a card given its id
    public func getCard(id: Int) -> Card {
        let tempCard = Card()
        return tempCard
    }
    
    // Return our list of cards
    public func getCards() -> [Card] {
        return cards
    }
}

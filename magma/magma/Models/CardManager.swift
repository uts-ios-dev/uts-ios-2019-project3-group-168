//
//  CardManager.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

class CardManager {
    // MARK: - Properties
    private var cards: [Card]
    
    // MARK: - Constructors
    init () {
        self.cards = []
    }
    
    // MARK: - Access
    // Return a card given its id
    public func getCard(_ id: Int) -> Card {
        let tempCard = Card()
        return tempCard
    }
    
    // Return our list of cards
    public func getCards() -> [Card] {
        return cards
    }
    
    // MARK: - Manipulation
    // Adds a new card to our wallet
    public func newCard(_ card: Card) {
        cards.append(card)
    }
    
    // Removes a card from our wallet
    public func removeCard(_ id: Int) {
        
    }
    
    // Reloads the cards in our wallet
    public func reload() {
        cards.removeAll()
    }
    
    // Deactivates a card in our wallet
    public func deactivateCard(_ id: Int) {
        
    }
}

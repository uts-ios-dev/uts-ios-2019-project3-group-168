//
//  Endpoints.swift
//  magma
//
//  Created by Justin Wilkin on 20/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

struct Endpoints {
    // Card Endpoints
    static let GET_CARDS = "/cards"
    static let GET_CARD = "/cards/id"
    static let NEW_CARD = "/cards/new"
    static let REMOVE_CARD = "/cards/remove/id"
    
    // Cardholder Endpoints
    static let NEW_CARD_HOLDER = "/cardholder/new"
    
    // Transaction Endpoints
    static let GET_TRANSACTIONS = "/transactions"
    
    // Parameters
    struct Params {
        static let CARD_HOLDER_ID = "cardholderID"
    }
}

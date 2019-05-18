//
//  CardAPI.swift
//  magma
//
//  Created by Justin Wilkin on 18/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import Alamofire

class CardAPI {
    // MARK: - Properties
    private let cardManager = CardManager()
    
    // MARK: - Singleton
    private static var sharedAPI: CardAPI = {
        let cardAPI = CardAPI()
        
        return cardAPI
    }()
    
    // Setup our Card API to access our server
    private init() {
        
    }
    
    // Provide our singleton as an object to our application
    public static func shared() -> CardAPI {
        return sharedAPI
    }
    
    // MARK: - Card Management
    // Load our cards from our server, requires a callback to be passed in. This handles the servers response
    // You should not continue until the request is resolved and the onResult callback is called
    public func loadCards(callback: @escaping (Int, String) -> Void) {
        let userID = 1234
        let server = Constants.SERVER_ADDRESS + "/getCards?userID=\(userID)"
        
        Alamofire.request(server).response { response in
            if (response.response?.statusCode == 200) {
                if let data = response.data, let text = String(data: data, encoding: .utf8) {
                    print("Data: \(text)")
                    callback(Constants.SUCCESS, "")
                }
            }
            
        }
    }
    
    public func getCard(id: Int) -> Card {
        return cardManager.getCard(id)
    }
    
    public func getCards() -> [Card] {
        return cardManager.getCards()
    }

    public func newCard() -> Card {
        return cardManager.newCard()
    }
    
    public func removeCard(id: Int) {
        cardManager.removeCard(id)
    }
    
    public func deactivateCard(id: Int) {
        cardManager.deactivateCard(id)
    }
}

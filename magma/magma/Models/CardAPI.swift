//
//  CardAPI.swift
//  magma
//
//  Created by Justin Wilkin on 18/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import Alamofire
import SwiftyJSON

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
    public func loadCards(_ callback: @escaping (Int, String) -> Void, controller: UIViewController) {
        let server: String = Environment().configuration(PlistKey.ServerURL) + Endpoints.GET_CARDS
        
        // Get request for our cards
        Alamofire.request(server, method: HTTPMethod.get, parameters: [Endpoints.Params.CARD_HOLDER_ID:Constants.userID]).responseJSON { response in
            
            if (response.result.isSuccess) {
                // Reload our local store of cards
                self.cardManager.reload()
                
                let data: JSON = JSON(response.result.value as Any)
                
                // Once we have received our card object from the server map it to a card locally
                let cardArray = data["cards"]
                
                if (cardArray != "null") {
                    // For each card in our cardholders wallet create a local card
                    // Stubbed out for testing without server
                    /*for (_, c) in cardArray {
                        let card = Util.cardFromJSON(c)
                        self.cardManager.newCard(card)
                    }*/
                    
                    // callback(Constants.SUCCESS, "")
                }
            }
            
            // Add some cards for testing without server
            for _ in 0...Util.getRandomIntInclusive(start: 1, end: 8) {
                self.cardManager.newCard(Card())
            }
            
            callback(Constants.SUCCESS, "")
        }
    }
    
    public func getCard(id: Int) -> Card {
        return cardManager.getCard(id)
    }
    
    public func getCards() -> [Card] {
        return cardManager.getCards()
    }
    
    // Send a request to our backend to create a new card
    public func newCard(_ callback: @escaping (Int, String) -> Void) {
        let server: String = Environment().configuration(PlistKey.ServerURL)
        
        // POST to our new card API to get a card object on its callback add the card locally
        Alamofire.request(server, method: HTTPMethod.post, parameters: [Endpoints.Params.CARD_HOLDER_ID:Constants.userID]).responseJSON { response in
            if (response.result.isSuccess) {
                let data: JSON = JSON(response.result.value as Any)
                
                // Once we have received our card object from the server map it to a card locally
                let card = Util.cardFromJSON(data)
                
                // Add the card to our card manager
                self.cardManager.newCard(card)
                
                // Notify the caller of the success
                callback(Constants.SUCCESS, "")
            } else {
                // Our server response was not 200 so let the caller know there was an error
                if let data = response.data, let error = String(data: data, encoding: .utf8) {
                    callback(Constants.FAILURE, error)
                }
            }
        }
    }
    
    public func removeCard(id: Int) {
        cardManager.removeCard(id)
    }
    
    public func deactivateCard(id: Int) {
        cardManager.deactivateCard(id)
    }
}

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
    public func loadCards(_ callback: @escaping (Int, String) -> Void) {
        var server: String {
            let address = ProcessInfo.processInfo.environment["SERVER_ADDRESS"]
            if  address != nil {
                return address! + "/getCards?userID=\(Constants.userID)"
            }
            
            return Constants.DEFAULT_SERVER
        }
        
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

    public func newCard(_ callback: @escaping (Int, String) -> Void) {
        var server: String {
            let address = ProcessInfo.processInfo.environment["SERVER_ADDRESS"]
            if  address != nil {
                return address! + "/card/new"
            }
            
            return Constants.DEFAULT_SERVER
        }
        
        Alamofire.request(server, method: HTTPMethod.post, parameters: ["cardholderID":Constants.userID]).responseJSON { response in
            print("Fired Request")
            if (response.result.isSuccess) {
                let data: JSON = JSON(response.result.value as Any)
                
                // Once we have received our card object from the server add the new card
                let cardID = data["id"].intValue
                let cardNumber = data["number"].stringValue
                let cardCVC = data["cvc"].stringValue
                let cardStatus = data["status"].boolValue
                let firstName = data["cardholder"]["firstName"].stringValue
                let middleName = data["cardholder"]["middleName"].stringValue
                let lastName = data["cardholder"]["lastName"].stringValue
                let cardName = "\(firstName) \(middleName.prefix(1)) \(lastName)"
                
                let card = Card(id: cardID, name: cardName, number: cardNumber, cvc: cardCVC, status: cardStatus)
                
                self.cardManager.newCard(card)
                callback(Constants.SUCCESS, "")
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

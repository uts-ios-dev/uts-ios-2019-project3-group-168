//
//  Constants.swift
//  magma
//
//  Created by Justin Wilkin on 17/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

final class Constants {
    // MARK: - Server
    static let DEFAULT_SERVER = "http://google.com/"
    static let userID = 1
    
    // MARK: - Response Codes
    static let SUCCESS = 1
    static let FAILURE = 2
    static let NOT_AUTHENTICATED = 3
    static let CONNECTION_ERROR = 4
    
    // MARK: - UI Strings
    static let APPLICATION_TITLE = "magma"
    static let CARD_HOLDER_NAME_TITLE = "Card Holder Name"
    static let CARD_EXPIRY_TITLE = "Expiry"
    static let CVC_TITLE = "CVC"
    static let NO_TRANSACTIONS = "No transactions to show"
    
    // MARK: - Function keys
    static let FUNCTION_BACK = "back"
    static let FUNCTION_PAY = "pay"
}

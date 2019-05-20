//
//  Environment.swift
//  magma
//
//  Class Adapted from Swift Documentation on environmental variables
//
//  Created by Justin Wilkin on 20/5/19.
//  Copyright © 2019 Code Candy. All rights reserved.
//

import Foundation

public enum PlistKey {
    case ServerURL
    
    func value() -> String {
        switch self {
        case .ServerURL:
            return "SERVER_ADDRESS"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            // swiftlint:disable:next force_cast
            return infoDict[PlistKey.ServerURL.value()] as! String
        }
    }
}

//
//  Environment.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import Foundation

/// AppConstant
public struct AppConstant {
    static let environment = Environment()
    static let socketURL = environment.configuration(PlistKey.socketURL) as? String ?? ""
    static let socketNameSpace = environment.configuration(PlistKey.SocketNameSpace) as? String ?? ""
}

/// PlistKey
public enum PlistKey {
    case socketURL
    case SocketNameSpace
    
    func value() -> String {
        switch self {
        case .socketURL:
            return "SocketURL"
        case .SocketNameSpace:
            return "SocketNameSpace"
        }
    }
    
}

/// Environment
public struct Environment {
    
    /// fetch data from info.plist
    fileprivate var infoDict: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    
    /// Provide value from info.plist file
    ///
    /// - Parameter key: Needed key
    /// - Returns: Get value in define datatype(Any you type cast later)
    func configuration(_ key: PlistKey) -> Any {
        switch key {
        case .socketURL:
            return infoDict[PlistKey.socketURL.value()] as? String ?? ""
        case .SocketNameSpace:
            return infoDict[PlistKey.SocketNameSpace.value()] as? String ?? ""
        }
    }
    
}

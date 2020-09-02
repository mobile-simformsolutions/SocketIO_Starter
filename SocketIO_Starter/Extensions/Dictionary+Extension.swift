//
//  Dictionary+Extension.swift
//  Curveball
//
//  Created by Abhi Makadiya on 09/07/20.
//  Copyright © 2020 Simform Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

extension Dictionary {

    var json: String {
        let invalidJson = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
}

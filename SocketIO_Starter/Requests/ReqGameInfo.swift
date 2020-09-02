//
//  ReqGameInfo.swift
//  Curveball
//
//  Created by Abhi Makadiya on 07/07/20.
//  Copyright © 2020 Simform Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

class ReqGameInfo: NSObject, NSCoding {

    var region: String?
    
    override init() {
        super.init()
    }
    
    func toDictionary() -> [String: Any] {
        var dictnary = [String: Any]()
        if region != nil {
            dictnary["region"] = region
        }
        
        return dictnary
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        region = aDecoder.decodeObject(forKey: "region") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        if region != nil {
            aCoder.encode(region, forKey: "region")
        }
    }
    
}

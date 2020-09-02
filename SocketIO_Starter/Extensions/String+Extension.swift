//
//  String+Extension.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

extension String {
    var jsonToData: Data? {
        
        if let jsonData = self.data(using: String.Encoding.utf8) {
            return jsonData
        } else {
            return nil
        }
        
    }
}

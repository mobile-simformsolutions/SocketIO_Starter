//
//  NotificationName+Extension.swift
//  Curveball
//
//  Created by Abhi Makadia on 23/06/20.
//  Copyright © 2020 Simform Solutions Pvt. Ltd. All rights reserved.
//

import UIKit

extension Notification.Name {
    //Socket
    static let socketEstablished = Notification.Name("socketEstablished")
    static let socketConnectNotify = Notification.Name("socketConnectNotify") 
    static let socketConnectionErrorNotify = Notification.Name("socketErrorConnectionNotify")
    static let socketDisconnectNotify = Notification.Name("socketDisconnectNotify")
}

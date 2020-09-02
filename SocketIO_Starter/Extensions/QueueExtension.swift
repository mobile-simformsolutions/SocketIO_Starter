//
//  QueueExtenstion.swift
//  Curveball
//
//  Created by Simform Solutions on 16/06/20.
//  Copyright © 2020 Simform Solutions Pvt. Ltd.. All rights reserved.
//

import UIKit

/// DispatchLevel manages the execution of work items. Each work item submitted to a queue is processed on a pool of threads managed by the system
public enum DispatchLevel {
    
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main: return DispatchQueue.main
        case .userInteractive: return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated: return DispatchQueue.global(qos: .userInitiated)
        case .utility: return DispatchQueue.global(qos: .utility)
        case .background: return DispatchQueue.global(qos: .background)
        }
    }
}

extension DispatchQueue {
    
    /// Provide to call any process after some delay
    ///
    /// - Parameters:
    ///   - seconds: after it will called
    ///   - dispatchLevel: The quality of service class
    ///   - closure: after call the exicution block
    public static func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
}

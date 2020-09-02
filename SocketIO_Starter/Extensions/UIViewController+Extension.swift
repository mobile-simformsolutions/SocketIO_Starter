//
//  UIViewController+Extension.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

/// Storyboards
enum Storyboard: String {
    case main = "Main"
}

///Instantiate View Controller
extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: Storyboard) -> T? {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

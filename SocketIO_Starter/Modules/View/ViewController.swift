//
//  ViewController.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -
    // MARK: - Variables
    var viewModel: ViewModel!
    
    // MARK: -
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: -
    // MARK: - Function Declaration
    func setupUI() {
        viewModel = ViewModel(del: self)
    }
}

// MARK: -
// MARK: - API Response Delegates
extension ViewController: APIResponseDelegate {
    func startFetchingData(apiName: String) {
        //You will get notify on start fetching Data
    }
    
    func endFetchingData(error: CustomError?, apiName: String) {
        //You will get notify on end fetching Data
    }
    
    func endFetchingDataNoAck(apiName: String) {
        //You will get notify on DataNoAcknowledgement
        //It help us to hide spinner after some time when response doesn't come.
    }
    
}

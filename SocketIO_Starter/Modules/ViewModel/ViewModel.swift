//
//  ViewModel.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

protocol APIResponseDelegate: class {
    func startFetchingData(apiName: String)
    func endFetchingData(error: CustomError?, apiName: String)
    func endFetchingDataNoAck(apiName: String)
}

class ViewModel: NSObject {

    // MARK: -
    // MARK: - Variables
    weak var delegate: APIResponseDelegate?
    var homeModel: HomeModel = HomeModel()
    //Socket Listener
    var gameInfoListener: UUID?
    
    // MARK: - Initializer
    override init() {
        super.init()
    }
    
    init(del: APIResponseDelegate) {
        super.init()
        delegate = del
        self.setupUI()
    }
    
    deinit {
        removeSocketHandlers()
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        socketHandlers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.hitGameinfo), name: .socketConnectNotify, object: nil)
    }
}

// MARK: -
// MARK: - API's
extension ViewModel {
    
    func socketHandlers() {
        removeSocketHandlers()
        onGameInfo()
    }
    
    func removeSocketHandlers() {
        //For remove socket listeners
        if let gameInfoList = gameInfoListener {
            SocketIOManager.shared.socket?.off(id: gameInfoList)
        }
    }
    
    // MARK: -
    // MARK: - Socket Handler Functions
    func onGameInfo() { //set game-info observer
        
        gameInfoListener = SocketIOManager.shared.socket?.on(SocketEmits.gameInfo) { [weak self] data, ack in

            guard let dictResp = data[0] as? [String: Any] else {
                return
            }
            SocketIOManager.shared.bindModel(response: dictResp) { [weak self] (result: Swift.Result<HomeModel, CustomError>) in
                    
                guard let uSelf = self else {
                    return
                }
                
                switch result {
                case .success(let homeModel):
                    uSelf.homeModel = homeModel
                    uSelf.delegate?.endFetchingData(error: nil, apiName: SocketEmits.gameInfo)
                case .failure(let error):
                    uSelf.delegate?.endFetchingData(error: error, apiName: SocketEmits.gameInfo)
                }
                
            }
        }
    }
    
    // MARK: -
    // MARK: - Socket Emit Functions
    @objc func hitGameinfo() { //Socket emit function
        guard SocketIOManager.shared.socket?.status == .connected else {
            return
        }
        
        let reqObj = ReqGameInfo()
        reqObj.region = TimeZone.current.identifier
        delegate?.startFetchingData(apiName: SocketEmits.gameInfo)
        SocketIOManager.shared.socket?.emitWithAck(SocketEmits.gameInfo, reqObj.toDictionary()).timingOut(after: 20) { [weak self] data in
            guard let this = self else {
                return
            }
            this.delegate?.endFetchingDataNoAck(apiName: SocketEmits.gameInfo)
        }
    }
}

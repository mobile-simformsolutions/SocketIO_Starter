//
//  SocketIOManager.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit
import SocketIO
import SVProgressHUD

class SocketIOManager: NSObject {

    // MARK: -
    // MARK: - Variable Declaration
    static let shared = SocketIOManager() //shared Instance
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    // MARK: -
    // MARK: - Initializer
    override init() {
        super.init()
    }
    
    // MARK: -
    // MARK: - Connection Handlers
    func establishConnection() {
        if socket == nil {
            createNewSocket()
            handler()
        } else {
            if socket?.status != .connected {
                SVProgressHUD.show()
                if let topVC = UIApplication.topViewController() {
                    topVC.view.isUserInteractionEnabled = false
                }
                socket?.connect()
            }
        }
    }
    
    func createNewSocket() {
        manager = SocketManager(socketURL: URL(string: AppConstant.socketURL)!, config: [.log(false), .reconnects(true), .forcePolling(true)])
        //If we want to add header in socket.
        renewSocketHeader()
        //Optional -> to add subDomain in socket connection url.
        socket = manager?.socket(forNamespace: AppConstant.socketNameSpace)
        SVProgressHUD.show()
        if let topVC = UIApplication.topViewController() {
            topVC.view.isUserInteractionEnabled = false
        }
        DispatchQueue.delay(bySeconds: 0.0) {
            NotificationCenter.default.post(name: .socketEstablished, object: nil)
        }
        socket?.connect()
    }
    
    func renewSocketHeader() {
        var dictHeader = [String: String]()
        dictHeader["Authorization"] = "Bearer <---Connection Token--->"
        manager?.config = SocketIOClientConfiguration(arrayLiteral: .compress, .extraHeaders(dictHeader))
    }
    
    func handler() {
        socket?.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            SVProgressHUD.dismiss()
            if let topVC = UIApplication.topViewController() {
                topVC.view.isUserInteractionEnabled = true
            }

            NotificationCenter.default.post(name: .socketConnectNotify, object: nil)
        }
        
        socket?.on(clientEvent: .disconnect) {data, ack in
            print("socket Disconnected")
            NotificationCenter.default.post(name: .socketDisconnectNotify, object: nil)
        }
        
        socket?.on(clientEvent: .error) {data, ack in
            print("socket Error")
            SVProgressHUD.show()
            if let topVC = UIApplication.topViewController() {
                topVC.view.isUserInteractionEnabled = false
            }
            NotificationCenter.default.post(name: .socketConnectionErrorNotify, object: nil)
        }
        
        socket?.on(clientEvent: .statusChange) {data, ack in
            print("socket Status Change")
        }
        
        socket?.on(clientEvent: .reconnect) { [weak self] data, ack in
            guard let this = self else {
                return
            }
            print("Socket reconnect")
            this.closeConnection()
            this.establishConnection()
        }
        
        socket?.on(clientEvent: .reconnectAttempt) {data, ack in
            print("Socket reconnect Attemp")
        }
        
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
    
    func eraseSocketData() {
        socket?.disconnect()
        socket = nil
        manager = nil
    }
    
    func bindModel<T>(response: [String: Any], handler: @escaping (Swift.Result<T, CustomError>) -> Void) where T: Codable {
        
        if self.handleResponseCode(res: response) {
            do {
                
                guard let dictData = response["data"] as? [String: Any] else {
                    throw CustomError(title: APIError.defaultAlertTitle, body: APIError.noData)
                }
                
                guard dictData.json.count > 0 else {
                    throw CustomError(title: APIError.defaultAlertTitle, body: APIError.noData)
                }
                guard let jsonData = dictData.json.jsonToData else {
                    throw CustomError(title: APIError.defaultAlertTitle, body: APIError.noData)
                }
                
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                handler(.success(result))
                
            } catch {
                print(error)
                if let error = error as? CustomError {
                    return handler(.failure(error))
                }
            }
        } else {
            handler(.failure(CustomError(title: APIError.errorAlertTitle, body: response["message"] as? String ?? "")))
        }
    }
    
    func handleResponseCode(res: [String: Any]) -> Bool {
        var isSuccess: Bool = false
        guard let statusCode = res["status"] as? Int else {return isSuccess}
        
        switch statusCode {
        case 200...300:
            isSuccess = true
        default: break
        }
        
        return isSuccess
    }
}

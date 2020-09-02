# SocketIO Starter

  

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)

  

This repository is an example project of [Socket.IO](https://github.com/socketio/socket.io-client-swift) configuration in IOS using Swift.

  

### Included Points

- Socket.io shared class that helps to establish socket in project.

- Socket configuration (establish, connect, disconnect, etc...)

- Handle socket connection.


  

### SocketIo Basic Functions Description

  

##### 1. How to create Socket instance and connect to the end server?

1. Initialize `SocketManager:`

```

let manager = SocketManager(socketURL: URL(string: AppConstant.socketURL)!, config: [.log(false), .reconnects(true), .forcePolling(true)])

```

- In config parameter, client can add multiple properties with type SocketIOClientConfiguration.

.log(Bool) -> If passed `true`, the client will log debug information. This should be turned off in production code.

.reconnects(Bool) -> If passed `false`, the client will not reconnect when it loses connection. Useful if you want full control over when reconnects happen.

.forcePolling(Bool) -> If passed `true`, the only transport that will be used will be HTTP long-polling.

  

2. get socket instance from `SocketManager:`

```

manager?.defaultSocket

```

- Client also can add `nsp` while fetching socket instance:

nsp(nameSpace) -> Use to add subDomain for the socket connection.

For example, for the server https://www.xyz.com has another subdomain "/user_socket" for socket connection.

To connect with the subDomain, create socket with nameSpace.

```

manager?.socket(forNamespace: "user_socket")

```

3. Client can connect socket instance with `.connect()` default method.

```

socket?.connect()

```

  

##### 2. How to add Header in socket?

Client can add header through `manager.config` variable with `.extraHeaders` param.

```

var dictHeader = [String: String]()

dictHeader["Authorization"] = "Bearer <---Connection Token--->"

manager?.config = SocketIOClientConfiguration(arrayLiteral: .compress, .extraHeaders(dictHeader))

```

`Important:`

Client can only add header before connection established. After socket connection, client can not change header object. For that, client need to create new instance of socket and reconnect to the server.

  

##### 3. How to emit event with socket?

`.emit` method is use to pass the dictionary object to the server with eventName.

```

SocketIOManager.shared.socket?.emitWithAck("eventName", reqObj.toDictionary()).timingOut(after: 20) { data in

}

```

  

##### 4. How to receive response from the server?

Call this `.on` method to observe the events. client gets notified when response has come.

```

SocketIOManager.shared.socket?.on("eventName") { data, ack in

guard let dictResp = data[0] as? [String: Any] else {

return

}

}

```

Here, response has come in first index of Array type in `.on` closure.

  

##### 5. How to disable socket listener?

socket.off will remove socket listener. Where id is unique UUID. Better to release listener before deinitialization.

It will help to release memory from ARC.

```

SocketIOManager.shared.socket?.off(id: listenerVariable)

```

  

### Important Note

- IOS Doesn't allow socket to connect in the background. For better usecase, disconnect socket when goes to background and connect it in foreground.
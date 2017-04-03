import Foundation
import SocketIO


let socket = SocketIOClient(socketURL: URL(string: "http://localhost:8080")!, config:[.log(true),.forcePolling(true)])

socket.on("connect"){data, ack in
    print("socket connected")
}

socket.on("currentAmount") {data, ack in

}


socket.connect()
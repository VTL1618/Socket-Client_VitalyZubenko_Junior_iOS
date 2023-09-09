//
//  SocketRoomViewController.swift
//  Task2_VitalyZubenko_Junior_iOS
//
//  Created by Vitaly Zubenko on 08.09.2023.
//

import UIKit

class SocketRoomViewController: UIViewController, URLSessionWebSocketDelegate {

//    let socketRoom = SocketRoom()
    
    private var webSocket: URLSessionWebSocketTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        socketRoom.setNetworkCommunication()
//    }
    
    func connect(serverURL: URL) {
        let session = URLSession(configuration: .default,
                                 delegate: self,
                                 delegateQueue: OperationQueue())
        let url = URL(string: "wss://connect.websocket.in/v3/1?api_key=&notify_self")
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
    }
    
    func ping() {
        webSocket?.sendPing { error in
            if let error = error {
                print("pind error: \(error)")
            }
        }
    }
    
    func close() {
        webSocket?.cancel(with: .abnormalClosure, reason: "Connection closed".data(using: .utf8))
    }
    
    func send(message: String) {
//        DispatchQueue.global().asyncAfter(deadline: .now()+1) {
//            self.send()
//            self.webSocket?.send(.string("Send new message: \(Int.random(in: 7...777))"), completionHandler: { error in
//                if let error = error {
//                    print("send error: \(error)")
//                }
//            })
//        }
        webSocket?.send(.string(message)) { error in
            if let error = error {
                print("send error: \(error)")
            }
        }
    }
    
    private func receive() {
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Received Data: \(data)")
                case .string(let message):
                    print("Received String: \(message)")
                    if message == "ping" {
                        self?.send(message: "pong")
                    }
                @unknown default:
                    break
                }
            case .failure(let error):
                print("receive error: \(error)")
            }
            
            self?.receive()
        })
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did connect to socket")
        ping()
        receive()
//        send(message: )
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Did close connection with reason")
    }
}


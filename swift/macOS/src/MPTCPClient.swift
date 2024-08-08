//
//  MPTCPClient.swift
//  mptcp-network
//
//  Created by Anthony Doeraene on 07/08/2024.
//

import Foundation
import Network

class MPTCPClient{
    var connection: NWConnection
    var queue: DispatchQueue
    var ready: Bool = false
    
    init(to server: NWEndpoint, params: NWParameters = .tls){
        queue = DispatchQueue(label: "MPTCP client Queue")
        
        params.multipathServiceType = .handover

        connection = NWConnection(to: server, using: params)
        
        connection.stateUpdateHandler = { [weak self] (newState) in
            switch (newState){
                case .waiting( _):
                    print("Waiting")
                case .ready:
                    self?.ready = true
                case .failed( _):
                    print("Failed")
                default:
                    break
            }
        }
    }
    
    func start(){
        connection.start(queue: queue)
        while !ready {}
    }
    
    func get(path: String) async -> String{
        let message = "GET \(path) HTTP/1.0\r\nUser-Agent: curl/1.0.0\r\n\n".data(using: .utf8)
        connection.send(content: message, completion: .contentProcessed({ (error) in
            if let error = error{
                print("Send error: \(error)")
            }
        }))
        
        return await withCheckedContinuation{continuation in
            connection.receive(minimumIncompleteLength: 0, maximumLength: 1024) { (content, context, isComplete, error) in
                if let content, let res = String(data: content, encoding: .ascii){
                    continuation.resume(returning: res)
                }
            }
        }
    }
}

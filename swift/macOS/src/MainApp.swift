//
//  main.swift
//  mptcp-network
//
//  Created by Anthony Doeraene on 07/08/2024.
//

import Foundation
import Network

@main
struct MainApp{
    static func main() async throws{
        let endpoint: NWEndpoint = .url(URL(string: "https://check.mptcp.dev")!)
        let client = MPTCPClient(to: endpoint)
        client.start()
        let res = await client.get(path: "/")
        print("Received response:\n\n\(res)")
    }
}


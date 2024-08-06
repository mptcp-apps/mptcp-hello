//
//  main.swift
//  swift-example
//
//  Created by Anthony Doeraene on 06/08/2024.
//

import Foundation

@main
struct MainApp{
    static func main() async throws{
        let url = URL(string: "https://check.mptcp.dev")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("curl/1.0.0", forHTTPHeaderField: "User-Agent")

        let session = URLSession.sharedMPTCP
        // note, you could also create a new session by using:
        // let session = URLSession(configuration: URLSessionConfiguration.defaultMPTCP)
        
        let (data, response) = try await session.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("Error doing request, received status code \(httpResponse.statusCode)")
            exit(1)
        }
        
        if let res = String(data: data, encoding: String.Encoding.utf8){
            print(res)
        }else{
            print("Failed to decode response")
            exit(1)
        }
    }
}

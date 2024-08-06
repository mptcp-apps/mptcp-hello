//
//  URLSession+sharedMPTCP.swift
//  swift-example
//
//  Created by Anthony Doeraene on 06/08/2024.
//

import Foundation

extension URLSession{
    static let sharedMPTCP: URLSession = URLSession(configuration: URLSessionConfiguration.defaultMPTCP)
}

//
//  URLSessionConfiguration+defaultMPTCP.swift
//  swift-example
//
//  Created by Anthony Doeraene on 06/08/2024.
//

import Foundation

extension URLSessionConfiguration{
    static var defaultMPTCP: URLSessionConfiguration{
        var conf = Self.default
        #if os(iOS)
            // multipath is only available on iOS, enable it only in this case
            conf.multipathServiceType = .handover
        #endif
        // if we aren't building for iOS, defaultMPTCP == default, thus fall back to TCP
        return conf
    }
}

//
//  Reachability.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 18/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import Foundation
import SystemConfiguration

class Reachability {
    
    // This is a checker that I use for a while now and, honestly, I don't remember the reference to insert here
    var isConnected: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

//
//  UserAgentString.swift
//  SwiftNest
//
//  Created by David House on 4/7/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public enum UserAgentString: String {
    case macOS
    case iPhone
    case iPad
    
    public func userAgentString() -> String {
        switch self {
        case .macOS:
            return "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15"
        case .iPhone:
            return "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML,like Gecko) Version/12.0 Mobile/15E148 Safari/604.1"
        case .iPad:
            return "Mozilla/5.0 (iPad; CPU iPad OS 12_2_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML,like Gecko) Version/12.0 Mobile/15E148 Safari/604.1"
        }
    }
}

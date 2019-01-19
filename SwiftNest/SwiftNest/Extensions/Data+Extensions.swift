//
//  Data+Extensions.swift
//  Lincoln
//
//  Created by David House on 9/13/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

extension Data {

    mutating func appendString(_ string: String) {

        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

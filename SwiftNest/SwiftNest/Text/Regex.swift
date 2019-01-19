//
//  Regex.swift
//  Lincoln
//
//  Created by David House on 12/9/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

public struct Regex: ExpressibleByStringLiteral, Equatable {

    fileprivate let expression: NSRegularExpression?

    public init(stringLiteral: String) {
        do {
            self.expression = try NSRegularExpression(pattern: stringLiteral, options: [])
        } catch {
            print("Failed to parse \(stringLiteral) as a regular expression")
            self.expression = nil
        }
    }

    fileprivate func match(_ input: String) -> Bool {
        guard let expression = expression else {
            return false
        }
        let result = expression.rangeOfFirstMatch(in: input, options: [],
                                                  range: NSRange(input.startIndex..., in: input))
        return !NSEqualRanges(result, NSRange(location: NSNotFound, length: 0))
    }
}

extension Regex {
    public static func ~= (pattern: Regex, value: String) -> Bool {
        return pattern.match(value)
    }
}

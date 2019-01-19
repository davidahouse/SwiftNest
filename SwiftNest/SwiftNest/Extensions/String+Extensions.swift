//
//  String+Extensions.swift
//  Lincoln
//
//  Created by David House on 12/8/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

extension Array: Listable where Element == String {

    public func numberOfColumns() -> Int {
        return 1
    }

    public func columnName(column: Int) -> String {
        return ""
    }

    public func numberOfRows() -> Int {
        return count
    }

    public func valueAt(column: Int, row: Int) -> String {
        return self[row]
    }

    public func identifier(for row: Int) -> String? {
        return self[row]
    }
}

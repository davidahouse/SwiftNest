//
//  Listable.swift
//
//  Created by davidahouse on 5/28/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

public protocol Listable {
    func numberOfColumns() -> Int
    func columnName(column: Int) -> String
    func numberOfRows() -> Int
    func valueAt(column: Int, row: Int) -> String
    func identifier(for row: Int) -> String?
}

//
//  ListableModel.swift
//  SwiftNestMac
//
//  Created by davidahouse on 7/7/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

struct ListableModel {
    
    let id: Int
    let title: String

    init() {
        id = Int(arc4random_uniform(2048))
        title = UUID().uuidString
    }
    
    static let testArray: [ListableModel] = {
        var array: [ListableModel] = []
        for i in 0...100 {
            array.append(ListableModel())
        }
        return array
    }()
}

extension Array : Listable where Element == ListableModel {
    
    func numberOfColumns() -> Int {
        return 2
    }
    
    func columnName(column: Int) -> String {
        switch column {
        case 1:
            return "ID"
        case 2:
            return "Name"
        default:
            return ""
        }
    }
    
    func numberOfRows() -> Int {
        return count
    }
    
    func valueAt(column: Int, row: Int) -> String {
        let item = self[row]
        switch column {
        case 1:
            return "\(item.id)"
        case 2:
            return item.title
        default:
            return ""
        }
    }
}

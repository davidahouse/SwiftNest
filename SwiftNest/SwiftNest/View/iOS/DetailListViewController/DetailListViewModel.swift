//
//  DetailListViewModel.swift
//  SwiftNest iOS
//
//  Created by David House on 4/4/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public struct DetailListItem {
    let title: String
    let subtitle: String?
    
    public init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
}

public struct DetailListViewModel {
    let title: String
    let details: [DetailListItem]

    public init(title: String, details: [DetailListItem]) {
        self.title = title
        self.details = details
    }
    
    static func emptyViewModel() -> DetailListViewModel {
        return DetailListViewModel(title: "", details: [])
    }
}

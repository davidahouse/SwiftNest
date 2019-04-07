//
//  SectionedDetailListViewModel.swift
//  SwiftNest iOS
//
//  Created by David House on 4/5/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public struct SectionedDetailListItem {
    let title: String
    let subtitle: String?
    
    public init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
}

public struct SectionedDetailListSection {
    let title: String
    let details: [SectionedDetailListItem]
    
    public init(title: String, details: [SectionedDetailListItem]) {
        self.title = title
        self.details = details
    }
}

public struct SectionedDetailListViewModel {
    let title: String
    let sections: [SectionedDetailListSection]
    
    public init(title: String, sections: [SectionedDetailListSection]) {
        self.title = title
        self.sections = sections
    }
    
    static func emptyViewModel() -> SectionedDetailListViewModel {
        return SectionedDetailListViewModel(title: "", sections: [])
    }
}

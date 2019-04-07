//
//  SectionedDetailListCoordinator.swift
//  SwiftNest iOS
//
//  Created by David House on 4/5/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public protocol SectionedDetailListDelegate: class {
    
}

public class SectionedDetailListCoordinator {
    
    public var viewController: SectionedDetailListViewModelConsumer?
    
    public init(viewController: SectionedDetailListViewModelConsumer? = nil) {
        if let viewControllerToCoordinate = viewController {
            self.viewController = viewControllerToCoordinate
        } else {
            self.viewController = SectionedDetailListViewController.create()
        }
    }
    
    public func configure(title: String, sections: [SectionedDetailListSection]) {
        let viewModel = SectionedDetailListViewModel(title: title, sections: sections)
        self.viewController?.viewModel = viewModel
    }
}

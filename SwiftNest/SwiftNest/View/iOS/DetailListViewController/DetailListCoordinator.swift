//
//  DetailListCoordinator.swift
//  SwiftNest iOS
//
//  Created by David House on 4/4/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public protocol DetailListDelegate: class {
    
}

public class DetailListCoordinator {
    
    public var viewController: DetailListViewModelConsumer?

    public init(viewController: DetailListViewModelConsumer? = nil) {
        if let viewControllerToCoordinate = viewController {
            self.viewController = viewControllerToCoordinate
        } else {
            self.viewController = DetailListViewController.create()
        }
    }
    
    public func configure(title: String, details: [DetailListItem]) {
        let viewModel = DetailListViewModel(title: title, details: details)
        self.viewController?.viewModel = viewModel
    }
}

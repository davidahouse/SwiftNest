//
//  ProgressView.swift
//  SwiftNest iOS
//
//  Created by David House on 3/2/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

public enum ProgressView {

    public static func create() -> ProgressViewModelConsumer? {

        let storyboard = UIStoryboard(name: "ProgressViewController", bundle: Bundle.init(for: ProgressViewController.self))
        guard let viewController = storyboard.instantiateInitialViewController() as? ProgressViewController else {
            return nil
        }
        return viewController
    }
}

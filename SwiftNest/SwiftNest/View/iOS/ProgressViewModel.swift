//
//  ProgressViewModel.swift
//  SwiftNest iOS
//
//  Created by David House on 3/2/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public protocol ProgressViewModelDelegate: class {
    func cancelSelected()
}

public protocol ProgressViewModelConsumer: ViewModelConsumer {
    var viewModel: ProgressViewModel { get set }
}

public struct ProgressViewModel {
    weak var delegate: ProgressViewModelDelegate?
    let message: String
    let progress: Int
    let total: Int

    public init(delegate: ProgressViewModelDelegate?, message: String, progress: Int, total: Int) {
        self.delegate = delegate
        self.message = message
        self.progress = progress
        self.total = total
    }

    static var emptyViewModel = ProgressViewModel(delegate: nil, message: "", progress: 0, total: 0)
}

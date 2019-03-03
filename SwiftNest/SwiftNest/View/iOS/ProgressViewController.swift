//
//  ProgressViewController.swift
//  SwiftNest iOS
//
//  Created by David House on 3/2/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

public class ProgressViewController: UIViewController, ProgressViewModelConsumer {

    @IBOutlet private var visualEffectView: UIVisualEffectView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var cancelButton: UIButton!

    public var viewModel: ProgressViewModel = ProgressViewModel.emptyViewModel {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overFullScreen
        activityIndicator.startAnimating()
        view.backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = 3.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2.0
    }

    private func updateUI() {
        messageLabel.text = viewModel.message
        if (viewModel.total > 0) {
            progressView.progress = Float(viewModel.progress) / Float(viewModel.total)
        } else {
            progressView.progress = 0.0
        }
        if viewModel.total > 0 && viewModel.progress >= viewModel.total {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            progressView.isHidden = true
            cancelButton.setTitle("Done", for: .normal)
        }
    }

    @IBAction func cancelPressed(_ sender: Any) {
        viewModel.delegate?.cancelSelected()
    }
}

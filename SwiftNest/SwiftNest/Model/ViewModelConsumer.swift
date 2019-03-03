//
//  ViewModelConsumer.swift
//  SwiftNest
//
//  Created by David House on 3/2/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

public protocol ViewModelConsumer {
    var consumerView: UIView? { get }
    func removeFromSuperview()
    func presentModal(_ viewControllerToPresent: ViewModelConsumer, animated flag: Bool, completion: (() -> Void)?)
    func dismissModal(animated flag: Bool, completion: (() -> Void)?)
}

extension UIViewController: ViewModelConsumer {

    public var consumerView: UIView? {
        get {
            return view
        }
    }

    public func removeFromSuperview() {
        consumerView?.removeFromSuperview()
    }

    public func presentModal(_ viewControllerToPresent: ViewModelConsumer, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let presentedModal = viewControllerToPresent as? UIViewController {
            self.present(presentedModal, animated: flag, completion: completion)
        }
    }

    public func dismissModal(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.dismiss(animated: flag, completion: completion)
    }
}

#elseif os(OSX)

#endif

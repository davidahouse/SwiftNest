//
//  UIView+Extensions.swift
//  SwiftNest
//
//  Created by David House on 3/12/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

public extension UIView {

    public func constrain(to view: UIView, top: CGFloat = 0.0, bottom: CGFloat = 0.0, left: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right).isActive = true
    }

    public func constrainToTopHalf(of view: UIView, top: CGFloat = 0.0, bottom: CGFloat = 0.0, left: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right).isActive = true
    }

    public func constrainToBottomHalf(of view: UIView, top: CGFloat = 0.0, bottom: CGFloat = 0.0, left: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: right).isActive = true
    }
}

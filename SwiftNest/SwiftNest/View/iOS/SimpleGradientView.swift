//
//  SimpleGradientView.swift
//  SwiftNest
//
//  Created by David House on 6/1/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import UIKit

class SimpleGradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    var gradientColors: [UIColor] = [UIColor.orange, UIColor.yellow] {
        didSet {
            gradientLayer.colors = gradientColors
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientColors
        layer.addSublayer(gradientLayer)
        backgroundColor = .clear
    }
}

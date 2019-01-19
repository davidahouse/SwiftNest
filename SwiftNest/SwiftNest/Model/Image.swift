//
//  Image.swift
//  LincolnFramework
//
//  Created by David House on 1/12/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import CoreGraphics

public typealias Image = UIImage

extension UIImage {
    public convenience init?(contentsOf: URL) {
        self.init(contentsOfFile: contentsOf.path)
    }
}

#elseif os(OSX)
import Cocoa
public typealias Image = NSImage

#endif

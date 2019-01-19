//
//  Font.swift
//  LincolnFramework
//
//  Created by David House on 1/13/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import CoreGraphics

public typealias Font = UIFont

#elseif os(OSX)
import Cocoa
public typealias Font = NSFont

#endif

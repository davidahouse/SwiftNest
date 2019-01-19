//
//  URL+Extension.swift
//  LincolnFramework
//
//  Created by David House on 1/16/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

extension URL {

    public func openInBrowser() {
        UIApplication.shared.open(self, options: [:], completionHandler: nil)
    }
}

#elseif os(OSX)
import AppKit

extension URL {

    public func openInBrowser() {
        NSWorkspace.shared.open(self)
    }
}

#endif

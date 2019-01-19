//
//  Color.swift
//  LincolnFramework
//
//  Created by David House on 11/25/18.
//  Copyright © 2018 repairward. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import CoreGraphics

public typealias Color = UIColor

extension UIColor {

    public static func colorString(color: Color) -> String {

        guard let colorRef = color.cgColor.components else {
            return ""
        }

        let red: CGFloat = colorRef[0]
        let green: CGFloat = colorRef[1]
        let blue: CGFloat = colorRef[2]
        let hexString = "\(red),\(green),\(blue)"
        return hexString as String
    }

    public static func stringToColor(colorString: String) -> Color {

        let colorParts = colorString.split(separator: ",")
        guard colorParts.count == 3 else {
            return Color.black
        }

        guard let red = NumberFormatter().number(from: String(colorParts[0])),
            let green = NumberFormatter().number(from: String(colorParts[1])),
            let blue = NumberFormatter().number(from: String(colorParts[2])) else {
                return Color.black
        }

        return Color.init(
            red: CGFloat(truncating: red) / 0xff,
            green: CGFloat(truncating: green) / 0xff,
            blue: CGFloat(truncating: blue) / 0xff, alpha: 1
        )
    }

    public static var textColor: Color {
        return UIColor.black
    }

    public static var textBackgroundColor: Color {
        return UIColor.white
    }
}

#elseif os(OSX)
import Cocoa
public typealias Color = NSColor

extension NSColor {

    public static func colorString(color: Color) -> String {

        guard let rgbColor = color.usingColorSpaceName(NSColorSpaceName.deviceRGB) else {
            return "FFFFFF"
        }
        let red = rgbColor.redComponent * 0xFF
        let green = rgbColor.greenComponent * 0xFF
        let blue = rgbColor.blueComponent * 0xFF
        let hexString = "\(red),\(green),\(blue)"
        return hexString as String
    }

    public static func stringToColor(colorString: String) -> Color {

        let colorParts = colorString.split(separator: ",")
        guard colorParts.count == 3 else {
            return Color.black
        }

        guard let red = NumberFormatter().number(from: String(colorParts[0])),
            let green = NumberFormatter().number(from: String(colorParts[1])),
            let blue = NumberFormatter().number(from: String(colorParts[2])) else {
            return Color.black
        }

        return Color.init(
            red: CGFloat(truncating: red) / 0xff,
            green: CGFloat(truncating: green) / 0xff,
            blue: CGFloat(truncating: blue) / 0xff, alpha: 1
        )
    }
}

#endif

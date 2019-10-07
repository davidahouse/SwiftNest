//
//  Logger.swift
//  SwiftNest
//
//  Created by David House on 10/6/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

enum Logger {
    /// Pulled from this gist:
    /// https://gist.github.com/atomicbird/d3e6f40663ab481f3d3c73428a2a9046
    /// Log the current filename and function, with an optional extra message. Call this with no arguments to simply print the current file and function. Log messages will include an Emoji selected from a list in the function, based on the hash of the filename, to make it easier to see which file a message comes from.
    /// - Parameter message: Optional message to include
    /// - Parameter file: Defaults to the filename where this function is called.
    /// - Parameter function: Defaults to the function name where this function is called.
    static func logMilestone(_ message: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        // Feel free to change the list of Emojis, but don't make it shorter, because a longer list is better.
        let logEmojis = ["😀","😎","😱","😈","👺","👽","👾","🤖","🎃","👍","👁","🧠","🎒","🧤","🐶","🐱","🐭","🐹","🦊","🐻","🐨","🐵","🦄","🦋","🌈","🔥","💥","⭐️","🍉","🥝","🌽","🍔","🍿","🎹","🎁","❤️","🧡","💛","💚","💙","💜","🔔"]
        let logEmoji = logEmojis[abs(file.hashValue % logEmojis.count)]
        if let message = message {
            print("Milestone: \(logEmoji) \((file as NSString).lastPathComponent):\(line) \(function): \(message)")
        } else {
            print("Milestone: \(logEmoji) \((file as NSString).lastPathComponent):\(line) \(function)")
        }
    }
}

//
//  FileProvider.swift
//  LincolnFramework
//
//  Created by David House on 1/14/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public protocol FileProvider {

    func modifiedDate(from url: URL) -> Date
    func save(contents: String, into url: URL)
    func save(contents: Data, into url: URL)
    func delete(at url: URL)
    func exists(at url: URL) -> Bool
    func directoryExists(at url: URL) -> Bool
    func ensurePathExists(for url: URL)
    func ensureUniquePath(for url: URL) -> URL
    func contentsOfDirectory(at url: URL) -> [URL]
    @discardableResult
    func rename(from oldPath: URL, to newPath: URL) -> Bool
    func copy(from fromPath: URL, to toPath: URL) -> Bool
    func move(from fromPath: URL, to toPath: URL) -> Bool
}

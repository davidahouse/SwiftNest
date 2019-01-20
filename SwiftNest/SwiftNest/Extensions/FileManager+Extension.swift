//
//  FileManager+Extension.swift
//  Lincoln
//
//  Created by David House on 10/27/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

extension FileManager: FileProvider {

    public func modifiedDate(from url: URL) -> Date {
        do {
            let attribues = try attributesOfItem(atPath: url.path)
            if let modifiedDate = attribues[FileAttributeKey.modificationDate] as? Date {
                return modifiedDate
            } else {
                return Date()
            }
        } catch {
            return Date()
        }
    }

    public func save(contents: String, into url: URL) {
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving file to: \(url)")
        }
    }

    public func save(contents: Data, into url: URL) {
        do {
            try contents.write(to: url)
        } catch {
            print("Error saving file to: \(url)")
        }
    }

    public func delete(at url: URL) {
        do {
            try removeItem(at: url)
        } catch {
            print("Error removing file at: \(url)")
        }
    }

    public func exists(at url: URL) -> Bool {
        return fileExists(atPath: url.path)
    }

    public func directoryExists(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        if fileExists(atPath: url.path, isDirectory: &isDirectory) {
            return isDirectory.boolValue
        } else {
            return false
        }
    }

    public func ensurePathExists(for path: URL) {
        do {
            if !fileExists(atPath: path.path) {
                try createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            }
        } catch {
            // ignore errors since path might already exist
            print("Error ensuring path exists: \(error)")
        }
    }

    public func ensureUniquePath(for url: URL) -> URL {
        var finalURL = url
        var count = 1
        let fileExtension = finalURL.pathExtension
        let fileName = finalURL.deletingPathExtension().lastPathComponent
        let baseURL = finalURL.deletingLastPathComponent()
        while fileExists(atPath: finalURL.path) {
            finalURL = baseURL.appendingPathComponent("\(fileName)_\(count).\(fileExtension)")
            count += 1
        }
        return finalURL
    }

    public func contentsOfDirectory(at url: URL) -> [URL] {

        do {
            let containerFiles = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            return containerFiles
        } catch {
            print("Error getting contents from \(url)")
            return []
        }
    }

    @discardableResult
    public func rename(from oldPath: URL, to newPath: URL) -> Bool {
        do {
            try moveItem(at: oldPath, to: newPath)
            return true
        } catch {
            print("Error trying to rename content: \(error) using urls \(oldPath) -> \(newPath)")
            return false
        }
    }

    public func copy(from fromPath: URL, to toPath: URL) -> Bool {
        do {
            try copyItem(at: fromPath, to: toPath)
            return true
        } catch {
            print("Error trying to copy content: \(error) using urls \(fromPath) -> \(toPath)")
            return false
        }
    }

    public func move(from fromPath: URL, to toPath: URL) -> Bool {
        do {
            try copyItem(at: fromPath, to: toPath)
            try removeItem(at: fromPath)
            return true
        } catch {
            print("Error trying to copy content: \(error) using urls \(fromPath) -> \(toPath)")
            return false
        }
    }
}

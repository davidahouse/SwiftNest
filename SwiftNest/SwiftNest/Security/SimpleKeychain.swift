//
//  SimpleKeychain.swift
//  SwiftNest
//
//  Created by David House on 1/31/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

class SimpleKeychain {

    public func read(using key: String) -> String? {
        let keychainQuery = query(using: key)
        keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keychainQuery.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)

        var result: CFTypeRef?
        let status = SecItemCopyMatching(keychainQuery, &result)
        guard let resultDictionary = result as? NSDictionary, let resultData = resultDictionary.value(forKey: kSecValueData as String) as? Data, status == noErr else {
            print("Unable to read from keychain: \(status)")
            return nil
        }
        return String(data: resultData, encoding: .utf8)
    }

    public func write(_ value: String?, using key: String) {
        let keychainQuery = query(using: key)
        let writeData: Data? = value?.data(using: .utf8, allowLossyConversion: false)

        if SecItemCopyMatching(keychainQuery, nil) == noErr {
            if let data = writeData {
                let updateDictionary = NSDictionary(dictionary: [kSecValueData: data])
                SecItemUpdate(keychainQuery, updateDictionary)
            } else {
                SecItemDelete(keychainQuery)
            }
        } else {
            if let data = writeData {
                keychainQuery.setValue(data, forKey: kSecValueData as String)
                SecItemAdd(keychainQuery, nil)
            }
        }
    }

    private func query(using key: String) -> NSMutableDictionary {
        let dictionary = NSMutableDictionary()
        dictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        dictionary.setValue(key, forKey: kSecAttrService as String)
        dictionary.setValue(kSecAttrAccessibleAlwaysThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return dictionary
    }
}

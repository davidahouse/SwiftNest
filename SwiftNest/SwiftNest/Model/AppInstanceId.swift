//
//  AppInstanceId.swift
//  SwiftNest
//
//  Created by David House on 2/10/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import Foundation

public struct AppInstanceId {
    public static var id: String {

        if let fromDefaults = UserDefaults.standard.string(forKey: "AppInstanceId") {
            return fromDefaults
        } else {
            let instanceId = UUID().uuidString
            UserDefaults.standard.setValue(instanceId, forKeyPath: "AppInstanceId")
            return instanceId
        }
    }
}

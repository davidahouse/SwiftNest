//
//  Editable.swift
//
//  Created by davidahouse on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

public protocol Editable {

    func details() -> [EditDetail]
    func updated(details: [EditDetail]) -> Editable
}

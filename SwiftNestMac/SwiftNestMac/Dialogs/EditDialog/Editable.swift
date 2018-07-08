//
//  Editable.swift
//
//  Created by davidahouse on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation
import CloudKit

protocol Editable {
    
    var record: CKRecord { get }
    
    func details() -> [EditDetail]
    func updated(details: [EditDetail]) -> Editable
}

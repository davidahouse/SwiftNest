//
//  EditDetails.swift
//
//  Created by David House on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

enum EditDetail {
    case title(String?)
    
    func label() -> String {
        switch self {
        case .title:
            return "Title"
        }
    }
    
    func editField() -> EditableField {
        
        switch self {
            
        case .title(let value):
            let textEdit = EditTextField(labelWithString: "")
            textEdit.isEditable = true
            textEdit.bezelStyle = .squareBezel
            textEdit.stringValue = value ?? ""
            return textEdit
        }
    }
    
    func value() -> String {
        switch self {
        case .title(let value):
            return value ?? ""
        }
    }
    
    func updated(value: String?) -> EditDetail {
        
        guard let value = value else {
            return self
        }
        
        switch self {
        case .title:
            return .title(value)
        default:
            return self
        }
    }
    
    func updated(dateValue: Date?) -> EditDetail {
        
        guard let dateValue = dateValue else {
            return self
        }
        
        switch self {
        default:
            return self
        }
    }
    
    func updated(doubleValue: Double?) -> EditDetail {
        
        guard let doubleValue = doubleValue else {
            return self
        }
        
        switch self {
        default:
            return self
        }
    }
}

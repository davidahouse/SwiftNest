//
//  EditField.swift
//
//  Created by davidahouse on 5/26/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

enum EditFieldKind {
    case text
    case currency
    case date
    case accountType
}

protocol EditField {
    
    var kind: EditFieldKind { get }
    
    func toString() -> String?
    func toDouble() -> Double?
    func toDate() -> Date?
}

typealias EditableField = EditField & NSControl

class EditTextField: NSTextField, EditField {
    
    let kind: EditFieldKind = .text
    
    func toDate() -> Date? {
        return nil
    }
    
    func toString() -> String? {
        return stringValue
    }
    
    func toDouble() -> Double? {
        return nil
    }
}

class EditCurrencyField: NSTextField, EditField {
    
    let kind: EditFieldKind = .currency
    
    func toDate() -> Date? {
        return nil
    }
    
    func toString() -> String? {
        return nil
    }
    
    func toDouble() -> Double? {
        
        if stringValue.contains("$") {
            return Formatter.stringToCurrency(stringValue)
        } else {
            return Formatter.stringToCurrency("$" + stringValue)
        }
    }
}

class EditDateField: NSDatePicker, EditField {
    
    let kind: EditFieldKind = .date
    
    func toDate() -> Date? {
        return dateValue
    }
    
    func toString() -> String? {
        return nil
    }
    
    func toDouble() -> Double? {
        return nil
    }
}

class EditAccountTypeField: NSPopUpButton, EditField {
    
    let kind: EditFieldKind = .accountType
    
    func toDate() -> Date? {
        return nil
    }
    
    func toString() -> String? {
        return titleOfSelectedItem
    }
    
    func toDouble() -> Double? {
        return nil
    }
}

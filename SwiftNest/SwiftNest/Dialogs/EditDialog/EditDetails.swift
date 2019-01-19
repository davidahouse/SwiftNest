//
//  EditDetails.swift
//
//  Created by David House on 5/20/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import AppKit

public enum EditDetail {
    case string(String, String?)
    case date(String, Date?)
    case double(String, Double?)

    func label() -> String {
        switch self {
        case .string(let label, _):
            return label
        case .date(let label, _):
            return label
        case .double(let label, _):
            return label
        }
    }

    func editField() -> EditableField {

        switch self {

        case .string(_, let value):
            let textEdit = EditTextField(labelWithString: "")
            textEdit.isEditable = true
            textEdit.bezelStyle = .squareBezel
            textEdit.stringValue = value ?? ""
            return textEdit
        case .double:
            // TODO: Convert value to string
            let textEdit = EditTextField(labelWithString: "")
            textEdit.isEditable = true
            textEdit.bezelStyle = .squareBezel
            textEdit.stringValue = ""
            return textEdit
        case .date:
            // TODO: Create a date edit field?
            let textEdit = EditTextField(labelWithString: "")
            textEdit.isEditable = true
            textEdit.bezelStyle = .squareBezel
            textEdit.stringValue = ""
            return textEdit
        }
    }

    func updated(value: String?) -> EditDetail {

        guard let value = value else {
            return self
        }

        switch self {
        case .string(let label, _):
            return .string(label, value)
        default:
            return self
        }
    }

    func updated(dateValue: Date?) -> EditDetail {

        guard let dateValue = dateValue else {
            return self
        }

        switch self {
        case .date(let label, _):
            return .date(label, dateValue)
        default:
            return self
        }
    }

    func updated(doubleValue: Double?) -> EditDetail {

        guard let doubleValue = doubleValue else {
            return self
        }

        switch self {
        case .double(let label, _):
            return .double(label, doubleValue)
        default:
            return self
        }
    }
}

extension Array where Element == EditDetail {

    func stringValue(for key: String) -> String? {

        for each in self {
            switch each {
            case .string(let label, let value):
                if label == key {
                    return value
                }
            default:
                break
            }
        }
        return nil
    }
}

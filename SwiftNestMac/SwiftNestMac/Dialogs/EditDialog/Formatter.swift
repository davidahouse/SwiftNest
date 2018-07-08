//
//  Formatter.swift
//
//  Created by davidahouse on 6/2/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

enum Formatter {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter
    }()
    
    static func dateToString(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func currencyToString(_ amount: Double) -> String {
        return currencyFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    static func stringToDate(_ dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    
    static func stringToCurrency(_ currencyString: String) -> Double? {
        
        guard let formatted = currencyFormatter.number(from: currencyString) else {
            return nil
        }
        
        return Double(truncating: formatted)
    }
}

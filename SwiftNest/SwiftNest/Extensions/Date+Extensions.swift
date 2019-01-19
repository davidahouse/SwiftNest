//
//  Date+Extensions.swift
//  Lincoln
//
//  Created by David House on 10/10/18.
//  Copyright © 2018 davidahouse. All rights reserved.
//

import Foundation

extension Date {

    public func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        let otherComponents = calendar.dateComponents([.year, .month, .day], from: otherDate)
        return components.year == otherComponents.year &&
            components.month == otherComponents.month &&
            components.day == otherComponents.day
    }

    static private var monthYearDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM_yyyy"
        return formatter
    }()

    static private var fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM_dd_yyyy"
        return formatter
    }()

    static private var fullDateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM_dd_yyyy_HH_mm_ss"
        return formatter
    }()

    public func monthYearDateString() -> String {
        return Date.monthYearDateFormatter.string(from: self)
    }

    public func fullDateString() -> String {
        return Date.fullDateFormatter.string(from: self)
    }

    public func fullDateAndTimeString() -> String {
        return Date.fullDateAndTimeFormatter.string(from: self)
    }
}

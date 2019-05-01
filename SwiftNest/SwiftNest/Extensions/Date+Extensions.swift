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
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
    
    public func isSameMonth(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let otherComponents = calendar.dateComponents([.year, .month], from: otherDate)
        return components.year == otherComponents.year &&
            components.month == otherComponents.month
    }

    public static func dateFrom(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        let parts = DateComponents(calendar: calendar, year: year, month: month, day: day)
        return calendar.date(from: parts)!
    }

    public func firstDayOfMonth() -> Date {
        let calendar = Calendar.current
        var parts = calendar.dateComponents([.month,.year,.day], from: self)
        parts.day = 1
        return calendar.date(from: parts)!
    }

    public func addMonth(_ numberOfMonths: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(month: numberOfMonths), to: self)!
    }

    public func addDay(_ numberOfDays: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(day: numberOfDays), to: self)!
    }

    public func subtractMonth(_ numberOfMonths: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(month: -numberOfMonths), to: self)!
    }

    public func subtractDay(_ numberOfDays: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: DateComponents(day: -numberOfDays), to: self)!
    }

    public func allDaysInMonth() -> [Date] {
        var results = [Date]()
        var current = firstDayOfMonth()
        while current.isSameMonth(as: self) {
            results.append(current)
            current = current.addDay(1)
        }
        return results
    }
}

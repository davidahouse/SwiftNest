//
//  DateExtensionsTests.swift
//  SwiftNestTests
//
//  Created by David House on 2/12/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import XCTest
@testable import SwiftNest

class DateExtensionsTests: XCTestCase {

    let referenceDate = Date.dateFrom(year: 2019, month: 1, day: 15)

    func testFirstDayOfCurrentMonthReturnsJanFirst() {
        let firstOfMonth = referenceDate.firstDayOfMonth()
        XCTAssertEqual(firstOfMonth, Date.dateFrom(year: 2019, month: 1, day: 1))
    }

    func testCanAddMonths() {
        let nextMonth = referenceDate.firstDayOfMonth().addMonth(1)
        XCTAssertEqual(nextMonth, Date.dateFrom(year: 2019, month: 2, day: 1))
    }

    func testCanSubtractMonths() {
        let previousMonth = referenceDate.firstDayOfMonth().subtractMonth(1)
        XCTAssertEqual(previousMonth, Date.dateFrom(year: 2018, month: 12, day: 1))
    }

    func testCanGenerateAllDaysInAMonth() {
        let allDaysInMonth = referenceDate.allDaysInMonth()
        XCTAssertEqual(allDaysInMonth.count, 31)
        XCTAssertEqual(allDaysInMonth[0], Date.dateFrom(year: 2019, month: 1, day: 1))
        XCTAssertEqual(allDaysInMonth[30], Date.dateFrom(year: 2019, month: 1, day: 31))
    }

    func testIsSameDayCanMatchDates() {
        let nextDate = referenceDate.addDay(1)
        let secondaryDate = nextDate.subtractDay(1)
        XCTAssertFalse(referenceDate.isSameDay(as: nextDate))
        XCTAssertTrue(referenceDate.isSameDay(as: secondaryDate))
    }
}

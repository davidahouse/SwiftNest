//
//  DataExtensionsTests.swift
//  SwiftNestTests
//
//  Created by David House on 2/15/19.
//  Copyright © 2019 repairward. All rights reserved.
//

import XCTest
@testable import SwiftNest

class DataExtensionsTests: XCTestCase {

    func testCanAppendStringToData() {

        let referenceString = "A quick brown fox"
        guard var referenceData = referenceString.data(using: .utf8) else {
            XCTFail("Unable to create a Data representation")
            return
        }

        referenceData.appendString(" jumped over the lazy dog")
        XCTAssertEqual(String(data: referenceData, encoding: .utf8), "A quick brown fox jumped over the lazy dog")
    }
}

//
//  APITests.swift
//  AppPracticeTests
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation
import XCTest
@testable import AppPractice

class APITests: XCTestCase {
	
	func testAPI() {
		// Given
		let urlString = "https://data.taipei/opendata/datalist/apiAccess?"
		let params: [String: Any] = [
			"scope": "resourceAquire",
			"rid": "f18de02f-b6c9-47c0-8cda-50efad621c14",
			"limit": 50,
			"offset": 0
		]
		
		// When
		WebService.shared.request(urlString: urlString, params: params, success: { data in
			// Then
			XCTAssertNotNil(data)
		}) { error in
			XCTAssert(false, "error!")
		}
	}
}

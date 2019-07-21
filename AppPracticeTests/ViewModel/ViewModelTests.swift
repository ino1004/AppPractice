//
//  ViewModelTests.swift
//  AppPracticeTests
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation
import XCTest
@testable import AppPractice

class ViewModelTestes: XCTestCase {
	
	// Given
	let viewModel = ViewModel()
	var plants: [Plant]?
	
	func testViewModelCallback() {
		let promise = expectation(description: "Invalid URL request")
		
		// When
		viewModel.loadingSuccessClosure = { plants in
			self.plants = plants
			promise.fulfill()
		}
		viewModel.loadData()
		wait(for: [promise], timeout: 10)
		
		// Then
		XCTAssertNotNil(plants)
	}
}

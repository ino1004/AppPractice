//
//  PlantCellTests.swift
//  AppPracticeTests
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation
import XCTest
@testable import AppPractice

class PlantCellTests: XCTestCase {
	
	func testCellSetup() {
		// Given
		let plant = Plant(name: "大花紫薇", location: "熱帶雨林區", feature: "可高達25公尺", pictureURLString: nil)
		if let cell = Bundle.main.loadNibNamed(String(describing: PlantCell.self), owner: self, options: nil)?.first as? PlantCell {
			
			// When
			cell.setup(with: plant)
			
			// Then
			XCTAssertTrue(cell.nameLabel.text == plant.name)
			XCTAssertTrue(cell.locationLabel.text == plant.location)
			XCTAssertTrue(cell.featureLabel.text == plant.feature)
		}
	}
}

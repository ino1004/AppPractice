//
//  PlantTests.swift
//  AppPracticeTests
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation
import XCTest
@testable import AppPractice

class PlantTests: XCTestCase {

	func testModel() {
		// Given
		let json = [
			"result": [
				"results": [
					["F_Name_Ch": "水黃皮",
					 "F_Location": "兒童動物區",
					 "F_Feature": "長30公分",
					 "F_Pic01_URL": ""]
				]
			]
		]
		
		// When
		do {
			let data = try JSONSerialization.data(withJSONObject: json, options: .init())
			PlantManager.shared.decodeToPlantModel(data, success: { models in
				if let model = models?.first {
					// Then
					XCTAssertTrue(model.name == json["result"]!["results"]![0]["F_Name_Ch"])
					XCTAssertTrue(model.location == json["result"]!["results"]![0]["F_Location"])
					XCTAssertTrue(model.feature == json["result"]!["results"]![0]["F_Feature"])
					XCTAssertTrue(model.pictureURLString == json["result"]!["results"]![0]["F_Pic01_URL"])
				}
			}) { error in
				XCTAssert(false, "error!")
			}
		} catch {
			XCTAssert(false, "error!")
		}
	}
}

//
//  Plant.swift
//  Test2
//
//  Created by Stephen Chui on 2019/7/18.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

struct Plant: Codable {
	let name: String?
	let location: String?
	let feature: String?
	let pictureURLString: String?
	
	private enum CodingKeys: String, CodingKey {
		case name = "F_Name_Ch"
		case location = "F_Location"
		case feature = "F_Feature"
		case pictureURLString = "F_Pic01_URL"
	}
}

struct PlantResults: Codable {
	let results: [Plant]
}

struct PlantResult: Codable {
	let result: PlantResults
}

//
//  PlantManager.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/21.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

class PlantManager {
	
	static let shared = PlantManager()
	
	func getData(_ offset: Int?, success: LoadingSuccessClosure?, failure: LoadingFailClosure?) {
		let plantURL = "https://data.taipei/opendata/datalist/apiAccess?"
		let limit: Int = 20
		
		let params: [String: Any] = [
			"scope": "resourceAquire",
			"rid": "f18de02f-b6c9-47c0-8cda-50efad621c14",
			"limit": limit,
			"offset": offset ?? 0
		]
		
		WebService.shared.request(urlString: plantURL, params: params, success: { [weak self] data in
			guard let `self` = self else { return }
			self.decodeToPlantModel(data, success: { plants in
				success?(plants)
			}, failure: { error in
				failure?(error)
			})
		}) { error in
			failure?(error)
		}
	}
	
	func decodeToPlantModel(_ data: Data, success: LoadingSuccessClosure?, failure: LoadingFailClosure?) {
		do {
			let decoder = JSONDecoder()
			let plantResult = try decoder.decode(PlantResult.self, from: data)
			success?(plantResult.result.results)
		} catch let error {
			failure?(error)
		}
	}
}

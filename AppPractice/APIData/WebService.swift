//
//  WebService.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation
import Alamofire

class WebService {
	
	static let shared = WebService()
	
	func request(urlString: String, params: Parameters?, success: ((Data) -> Void)?, failure: ((Error?) -> Void)?) {
		guard let url = URL(string: urlString) else { return }
		
		Alamofire.request(url, parameters: params).response { response in
			guard response.error == nil else {
				failure?(response.error)
				return
			}
			
			guard let data = response.data else {
				failure?(response.error)
				return
			}
			
			success?(data)
		}
	}
}

//
//  ViewModelDataProtocol.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

protocol ViewModelDataProtocol: class {
	var models: [Plant] { get set }
	var datasCount: Int { get }
	var loadingDelegate: ViewModelLoadingDelegate? { get set }
	var loadingStatusDelegate: ViewModelLoadingStatusDelegate? { get set }
	
	func loadData(_ offset: Int?)
}

extension ViewModelDataProtocol {
	
	var datasCount: Int { return models.count }
	
	func model(at index: Int) -> Plant? {
		return models[safe: index]
	}
}

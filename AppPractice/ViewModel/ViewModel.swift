//
//  ViewModel.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

typealias LoadingSuccessClosure = ([Plant]?) -> Void
typealias LoadingFailClosure = (Error?) -> Void

class ViewModel: ViewModelDataProtocol {
	
	var models: [Plant] = []
	
	var loadingSuccessClosure: LoadingSuccessClosure?
	var loadingFailClosure: LoadingFailClosure?
	
	weak var loadingDelegate: ViewModelLoadingDelegate?
	weak var loadingStatusDelegate: ViewModelLoadingStatusDelegate?
	
	init() {
		setupClosure()
	}
	
	fileprivate func setupClosure() {
		loadingSuccessClosure = { [weak self] plants in
			guard let `self` = self else { return }
			guard let plants = plants else { return }
			self.models.append(contentsOf: plants)
			DispatchQueue.main.async {
				self.loadingStatusDelegate?.showLoading(false)
				self.loadingDelegate?.loadDone()
			}
		}
		
		loadingFailClosure = { [weak self] error in
			guard let `self` = self else { return }
			// Error handling
			DispatchQueue.main.async {
				self.loadingStatusDelegate?.showLoading(false)
				self.loadingDelegate?.loadFail(error)
			}
		}
	}
	
	func loadData(_ offset: Int? = nil) {
		DispatchQueue.main.async {
			self.loadingStatusDelegate?.showLoading(true)
		}
		PlantManager.shared.getData(offset, success: loadingSuccessClosure, failure: loadingFailClosure)
	}
}

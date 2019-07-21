//
//  ViewModelLoadingDelegate.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

protocol ViewModelLoadingDelegate: class {
	func loadDone()
	func loadFail(_ error: Error?)
}

protocol ViewModelLoadingStatusDelegate: class {
	func showLoading(_ isShow: Bool)
}

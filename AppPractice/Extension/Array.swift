//
//  Array.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/20.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import Foundation

extension Array {
	
	// Get the element of array safely
	subscript(safe index: Int) -> Element? {
		return (0 <= index && index < count) ? self[index] : nil
	}
}

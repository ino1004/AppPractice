//
//  StickyHeaderView.swift
//  Test2
//
//  Created by Stephen Chui on 2019/7/18.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import UIKit

class StickyHeaderView: UIView {

	@IBOutlet weak var titleLabel: UILabel! {
		didSet {
			titleLabel.alpha = 0.0
			titleLabel.text = "HeaderHeaderHeader"
		}
	}
	
	public static func instance() -> StickyHeaderView? {
		return UINib(nibName: String(describing: StickyHeaderView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? StickyHeaderView
	}

}

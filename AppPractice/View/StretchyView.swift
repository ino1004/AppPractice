//
//  StretchyView.swift
//  Test2
//
//  Created by Stephen Chui on 2019/7/18.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import UIKit

protocol StretchyViewSetting {
	func setup(withHeight height: CGFloat, on view: UIView)
}

class StretchyView: UIView {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	public static func instance() -> StretchyView? {
		return UINib(nibName: String(describing: StretchyView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? StretchyView
	}
}

extension StretchyView: StretchyViewSetting {

	func setup(withHeight height: CGFloat, on view: UIView) {
		self.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(self)
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			self.heightAnchor.constraint(equalToConstant: height)
			])
		view.sendSubviewToBack(self)
	}
}

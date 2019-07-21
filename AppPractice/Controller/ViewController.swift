//
//  ViewController.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/18.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	private lazy var stretchViewHeight: CGFloat = 150
	
	private lazy var stretchyView: StretchyView = {
		guard let _stretchyView = StretchyView.instance() else {
			return StretchyView(frame: .zero)
		}
		return _stretchyView
	}()
	
	private var stickyHeaderView: StickyHeaderView?

	private lazy var viewModel: ViewModel = ViewModel()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		viewModel.loadingDelegate = self
		viewModel.loadingStatusDelegate = self
		viewModel.loadData()
	}
	
	
	// MARK: - Setup
	
	private func setupViews() {
		tableView.register(UINib(nibName: String(describing: PlantCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PlantCell.self))
		tableView.contentInset = UIEdgeInsets(top: stretchViewHeight, left: 0, bottom: 0, right: 0)
		
		stretchyView.setup(withHeight: stretchViewHeight, on: view)
	}

	// MARK: - Stretch animation
	
	private func stretchWithOffset(_ contentOffset: CGPoint) {
		let contentOffsetY = -contentOffset.y
		let midY = stretchViewHeight / 2
		
		guard contentOffsetY > 0 else { return }
		guard contentOffsetY < stretchViewHeight else { return }
		
		UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 4.0, initialSpringVelocity: 6.0, options: .curveEaseInOut, animations: {
			if contentOffsetY < midY {
				// Collapse
				self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
				self.tableView.contentOffset = CGPoint(x: 0, y: 0)
				self.stickyHeaderView?.titleLabel.alpha = 1.0
			} else {
				// Expand
				self.tableView.contentInset = UIEdgeInsets(top: self.stretchViewHeight, left: 0, bottom: 0, right: 0)
				self.tableView.contentOffset = CGPoint(x: 0, y: -self.stretchViewHeight)
				self.stickyHeaderView?.titleLabel.alpha = 0.0
			}
		}, completion: nil)
	}
	
	
	// MARK: - IndicatorView
	
	private func showIndicatorView(_ isShow: Bool) {
		if isShow {
			let indicatorView = UIActivityIndicatorView(style: .gray)
			indicatorView.startAnimating()
			indicatorView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
			
			tableView.tableFooterView = indicatorView
			tableView.tableFooterView?.isHidden = false
		} else {
			tableView.tableFooterView = nil
		}
	}
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.datasCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PlantCell.self), for: indexPath) as? PlantCell {
			if let model = viewModel.model(at: indexPath.row) {
				cell.setup(with: model)
			}
			
			return cell
		}
		
		return UITableViewCell()
	}
}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let headerView = StickyHeaderView.instance() {
			stickyHeaderView = headerView
			return headerView
		}
		
		return UIView()
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 60
	}
}


// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffsetY = scrollView.contentOffset.y
		
		// Adjust inset
		let insetY = -contentOffsetY < 0 ? 0 : -contentOffsetY
		tableView.contentInset = UIEdgeInsets(top: insetY, left: 0, bottom: 0, right: 0)
		
		// Adjust offset
		if contentOffsetY < -stretchViewHeight {
			tableView.contentOffset = CGPoint(x: 0, y: -stretchViewHeight)
		}
		
		// StretchyView's alpha
		let stretchyViewAlpha = -contentOffsetY / stretchViewHeight
		stretchyView.alpha = stretchyViewAlpha
		
		// StickyHeaderView.titleLabel
		// 2/3 height of the stretchViewHeight
		let headerViewAlpha = 1 - (-contentOffsetY / (stretchViewHeight * 2/3))
		stickyHeaderView?.titleLabel.alpha = headerViewAlpha
	}
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		guard !decelerate else { return }
		stretchWithOffset(scrollView.contentOffset)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		// Fetch data while the scrollView stop decelerating and the offset less than 10.0
		let currentOffset = scrollView.contentOffset.y
		let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
		if maximumOffset - currentOffset <= 10.0 {
			viewModel.loadData(viewModel.datasCount)
		}
		
		stretchWithOffset(scrollView.contentOffset)
	}
}


// MARK: - ViewModelLoadingDelegate

extension ViewController: ViewModelLoadingDelegate {
	
	func loadDone() {
		tableView.reloadData()
	}
	
	func loadFail(_ error: Error?) {
		
	}
}


// MARK: - ViewModelLoadingStatusDelegate

extension ViewController: ViewModelLoadingStatusDelegate {
	
	func showLoading(_ isShow: Bool) {
		showIndicatorView(isShow)
	}
}

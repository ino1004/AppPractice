//
//  PlantCell.swift
//  AppPractice
//
//  Created by Stephen Chui on 2019/7/18.
//  Copyright © 2019 Stephen Chui. All rights reserved.
//

import UIKit
import SDWebImage

class PlantCell: UITableViewCell {

	@IBOutlet weak var pictureImageView: UIImageView! {
		didSet {
			pictureImageView.clipsToBounds = false
			pictureImageView.layer.shadowColor = UIColor.darkGray.cgColor
			pictureImageView.layer.shadowOpacity = 0.6
			pictureImageView.layer.shadowRadius = 6.0
			pictureImageView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
		}
	}
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var featureLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
		setupViews()
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		setPlaceHolderImage()
	}
	
	private func setupViews() {
		setPlaceHolderImage()
	}

	func setup(with plant: Plant) {
		if let urlString = plant.pictureURLString, let url = URL(string: urlString) {
			pictureImageView.sd_setImage(with: url, placeholderImage: UIImage(color: .white), completed: nil)
		}
		nameLabel.text = plant.name
		locationLabel.text = plant.location
		featureLabel.text = plant.feature
	}
	
	private func setPlaceHolderImage() {
		pictureImageView.image = UIImage(color: .white)
	}

}

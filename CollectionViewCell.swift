//
//  CollectionViewCell.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 06/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var categoryNameLabel: UILabel!
	@IBOutlet weak var categoryImageView: UIImageView! {
		didSet {
			self.categoryImageView.contentMode = .scaleToFill
		}
	}
	
	func configureCellView(_ categoryAndCategoryImage: (quotesText: String, imageURL: String)) {
		self.categoryNameLabel.text = categoryAndCategoryImage.quotesText
		self.categoryImageView.downloadImage(from: categoryAndCategoryImage.imageURL)
	}
}

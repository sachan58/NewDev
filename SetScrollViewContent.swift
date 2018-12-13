//
//  ScrollViewData.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 07/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import UIKit

class SetScrollViewContent {
	
	class func setSubview(_ scrollView: UIScrollView) {
		scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 4, height: scrollView.frame.size.height)
		var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
		let imageView = UIImageView()
		var imageArray = [UIImage(named: "quotes"), UIImage(named: "earth"), UIImage(named: "double")]
		for index in 0..<3 {
			frame.origin.x = scrollView.frame.size.width * CGFloat(index)
			frame.size = scrollView.frame.size
			imageView.image = imageArray[index]
			imageView.contentMode = .scaleToFill
			imageView.frame = frame
			scrollView.addSubview(imageView)
		}
	}
}

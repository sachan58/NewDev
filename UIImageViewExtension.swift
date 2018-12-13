//
//  FetchImageFromUrl.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 06/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import UIKit

extension UIImageView {
	func downloadImage(from url: String) {
		guard let url =  URL(string: url) else { return }
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let data = data, error == nil,
				let image = UIImage(data: data) else {
					print("error")
					return
			}
			DispatchQueue.main.async {
				self.image = image
			}
		}
		task.resume()
	}
}

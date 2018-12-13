//
//  InspirationalQuotesModel.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 13/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import Foundation

class InspirationalQuotesModel {
	
	private var quoteText: String?
	private var imageURL: String?
	
	init(_ quoteText: String, _ imageURL: String) {
		self.quoteText = quoteText
		self.imageURL = imageURL
	}
}

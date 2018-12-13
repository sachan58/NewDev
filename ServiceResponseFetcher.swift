//
//  File.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 05/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import Foundation

class FetchResponseFromServer {
	
	class func getResponse(completionBlock: @escaping (([[String : Any]]) -> Void)) {
		
		let dataToPost: [String : Any] = ["secure_key" : "Android",
										  "type_id" : 1]
		let dataToPostInJson = try? JSONSerialization.data(withJSONObject: dataToPost)
		let urlString = URL(string: "http://apis.ameyapps.in/inspireme/v1/fetchQuotesCatWithId")
		
		if let url = urlString {
			var request = URLRequest(url: url)
			request.httpMethod = "POST"
			request.httpBody = dataToPostInJson
			let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
				if error != nil {
					print(error as Any)
				} else {
					if let reusableData = data {
						guard let parsedData = try? JSONSerialization.jsonObject(with: reusableData, options: []) as? [String : Any], let quotesData = parsedData?["quotesList"] as? [[String : Any]] else { return }
						print(quotesData)
						completionBlock(quotesData)
					}
				}
			}
			task.resume()
		}
	}
}

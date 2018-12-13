//
//  InspirationalQuotes.swift
//  Inspire_Me
//
//  Created by Manoj Nimbalkar on 05/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.

import Foundation
import CoreData
import UIKit

class InspirationalQuotesData {
	
	typealias CategoryField = (quotesText: String, imageURL: String)
	private var categories: [CategoryField] = []
	private var quotesManagedObject: [NSManagedObject] = []
	
	init(data: [[String : Any]]) {
		for dictionary in data {
			categories.append((dictionary["category_name"] as? String ?? "", dictionary["image_url"] as? String ?? ""))
		}
		self.storeData()
	}
	
	private func storeData() {
		DispatchQueue.main.async {
			guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
			let managedContext = appDelegate.persistentContainer.viewContext
			guard let entity = NSEntityDescription.entity(forEntityName: "Quotes", in: managedContext) else { return }
			let quotes = NSManagedObject(entity: entity, insertInto: managedContext)
				for i in self.categories {
					quotes.setValue(i.quotesText, forKeyPath: "quotesText")
					do {
						try managedContext.save()
						self.quotesManagedObject.append(quotes)
					} catch let error as NSError {
						print("Could not save. \(error), \(error.userInfo)")
					}
			}
		}
	}
	
	func numberOfCollectionViewItems() -> Int? {
		return self.categories.count
	}
	
	func getQuotesCategoryAndImageUrl(_ indexPath: IndexPath) -> (quotesText: String, imageURL: String) {
		return(categories[indexPath.row])
	}
}

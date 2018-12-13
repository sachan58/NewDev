//
//  ViewController.swift
//  Inspire_Me
//
//  Created by Priyanka Sachan on 05/12/18.
//  Copyright © 2018 Priyanka Sachan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController  {

	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var scrollView: UIScrollView!
	
	@IBAction func pageChange(_ sender: Any) {
		let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
		scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
	}
	var isConnected = false
	private var offlineData: [NSManagedObject] = [] {
		didSet {
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	private var viewQuotesData: InspirationalQuotesData? {
		didSet {
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		if Reachability.isConnectedToNetwork() {
			isConnected = true
			FetchResponseFromServer.getResponse { quotesData in
				self.viewQuotesData = InspirationalQuotesData(data: quotesData)
			}
		} else {
			DispatchQueue.main.async {
				guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
				let managedContext = appDelegate.persistentContainer.viewContext
				let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Quotes")
				do {
					self.offlineData = try managedContext.fetch(fetchRequest)
				} catch let error as NSError {
					print("Could not fetch. \(error), \(error.userInfo)")
				}
			}
		}
		self.setupUI()
	}
	
	private func setupUI() {
		self.scrollView.delegate = self
		SetScrollViewContent.setSubview(self.scrollView)
		self.navigationItem.title = "Quotes"
	}
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return (self.isConnected ? self.viewQuotesData?.numberOfCollectionViewItems() ?? 0 : offlineData.count)
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "quotesType", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
		if self.isConnected, let cellData = self.viewQuotesData {
			cell.configureCellView(cellData.getQuotesCategoryAndImageUrl(indexPath))
		} else {
			cell.categoryNameLabel.text = offlineData[indexPath.row].value(forKeyPath: "quotesText") as? String
			cell.categoryImageView.image = UIImage(named: "double")
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//		guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationsTableViewController") as? ConversationsTableViewController else { return }
//		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension ViewController: UIScrollViewDelegate {
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let pageNo = round(scrollView.contentOffset.x / scrollView.frame.size.width)
		pageControl.currentPage = Int(pageNo)
	}
}

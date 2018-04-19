//
//  ViewController.swift
//  Product Listing
//
//  Created by Razvan Julian on 18/04/2018.
//  Copyright © 2018 Razvan Julian. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var loadingMoreView:InfiniteScrollActivityView?

    let gridCellIdentifier = "GridCell"
    let listCellIdentifier = "ListCell"
    
    var toggleButton = UIBarButtonItem()
    var isListView = false
    
    
    let itemsDisplayedPerBatch = 10
    var batchCounter = 0
    var counter = 0
    
    
    var jsonProductCount = 0
    var jsonTitle = ""
    
    
    var displayNames = [String]()
    var displayPrices = [String]()
    var displayImages = [UIImage]()
    
    var IDs = [Int]()
    var names = [String]()
    var prices = [String]()
    var images = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Test"
                
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(GridCell.self, forCellWithReuseIdentifier: gridCellIdentifier)
        collectionView?.register(ListCell.self, forCellWithReuseIdentifier: listCellIdentifier)
        
        //toggleButton = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(butonTapped(sender:)))
        toggleButton = UIBarButtonItem(image: UIImage(named: "black-square"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: (collectionView?.contentSize.height)!, width: (collectionView?.bounds.size.width)!, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        collectionView?.addSubview(loadingMoreView!)
        
        var insets = collectionView?.contentInset
        insets?.bottom += InfiniteScrollActivityView.defaultHeight
        collectionView?.contentInset = insets!
            

        let dataURL = "https://www.endclothing.com/media/catalog/example.json"
        
        Alamofire.request(dataURL, method: .get)
            .responseJSON { response in
                
                var json = JSON(response.result.value!)
                
                if json["title"].string != nil {
                    self.jsonTitle = json["title"].string!
                    self.title = self.jsonTitle
                }
                
                if json["product_count"].int != nil {
                    self.jsonProductCount = json["product_count"].int!
                }
                
                
                if json["products"].count > 0 && self.jsonProductCount > 0 {
                    
                    if let products = json["products"].array {
                        
                        for product in products {
                            
                            if let id = product["id"].string {
                            
                                if let name = product["name"].string {
                            
                                    if let price = product["price"].string {
                            
                                        if let imageString = product["image"].string {
                            
                            
                                            self.IDs.append(Int(id)!)
                                            self.names.append(name)
                                            self.prices.append(price)
                                
                                            let imageURL = NSURL(string: imageString)
                                            let imageData = NSData(contentsOf: imageURL! as URL)
                                            let image = UIImage(data: imageData! as Data)
                                            self.images.append(image!)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                for _ in 1...self.itemsDisplayedPerBatch {
                    if self.counter < self.itemsDisplayedPerBatch {
                                self.displayNames.append(self.names[self.counter])
                                self.displayPrices.append(self.prices[self.counter])
                                self.displayImages.append(self.images[self.counter])
                                self.counter += 1
                    }
            }
                
            self.collectionView?.reloadData()
            self.batchCounter += 1

        }

    }
    
    
    @objc func butonTapped(sender: UIBarButtonItem) {
        if isListView {
            toggleButton = UIBarButtonItem(image: UIImage(named: "black-square"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
            
        } else {
            toggleButton = UIBarButtonItem(image: UIImage(named: "four-black-squares"), style: .plain, target: self, action: #selector(butonTapped(sender:)))
        }
        
        isListView = !isListView
        
        self.navigationItem.setRightBarButton(toggleButton, animated: true)
        self.collectionView?.reloadData()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isListView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCellIdentifier, for: indexPath) as! ListCell
            cell.nameLabel.text = self.displayNames[indexPath.row]
            cell.priceLabel.text = self.displayPrices[indexPath.row]
            cell.imgView.image = self.displayImages[indexPath.row]
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridCellIdentifier, for: indexPath) as! GridCell
            cell.nameLabel.text = self.displayNames[indexPath.row]
            cell.priceLabel.text = self.displayPrices[indexPath.row]
            cell.imgView.image = self.displayImages[indexPath.row]
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if isListView {
            return CGSize(width: width, height: 400)
        } else {
            return CGSize(width: (width - 15)/2, height: (width - 15)/2 + 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Calculate the position of one screen length before the bottom of the results
        let scrollViewContentHeight = collectionView?.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight! - (collectionView?.bounds.size.height)!
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && (collectionView?.isDragging)!) {
            
            // Update position of loadingMoreView, and start loading indicator
            let frame = CGRect(x: 0, y: (collectionView?.contentSize.height)!, width: (collectionView?.bounds.size.width)!, height: InfiniteScrollActivityView.defaultHeight)
            loadingMoreView?.frame = frame
            loadingMoreView!.startAnimating()
            
            loadMoreData()
        }
    }

    
    func loadMoreData() {
        if jsonProductCount > counter {
            for _ in 1...itemsDisplayedPerBatch {
                if counter < itemsDisplayedPerBatch * batchCounter {
                    self.displayNames.append(self.names[self.counter])
                    self.displayPrices.append(self.prices[self.counter])
                    self.displayImages.append(self.images[self.counter])
                    self.counter += 1
                }
            }
            
            self.collectionView?.reloadData()
            self.batchCounter += 1
            self.loadingMoreView!.stopAnimating()
            
        } else if jsonProductCount == counter {
            self.loadingMoreView!.stopAnimating()
        }
    }
    
}

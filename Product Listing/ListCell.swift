//
//  ListCell.swift
//  Product Listing
//
//  Created by Razvan Julian on 18/04/2018.
//  Copyright © 2018 Razvan Julian. All rights reserved.
//

import UIKit
import SnapKit

class ListCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let imgView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Golden-Retriever")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
        return label
    }()
    
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        return label
    }()
    
    
    func setUpViews() {
        
        backgroundColor = UIColor.clear
        
        addSubview(imgView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30).priority(750)
            make.right.equalTo(self).offset(-30).priority(750)
            
            make.width.lessThanOrEqualTo(500)
            
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-50)
            
            //self.centerYConstraint = make.centerY.equalTo(self).constraint
            make.height.equalTo(CGFloat(250.0))//192.0))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(100)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(150)
        }
 
    }
}


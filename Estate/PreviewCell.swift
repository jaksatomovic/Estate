//
//  PreviewCell.swift
//  Estate
//
//  Created by Jaksa Tomovic on 05/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class PreviewCell: BaseCell {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        iv.image = UIImage(named: "bg-city")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.textColor = .white
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = nameLabel.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 16)
    }
}

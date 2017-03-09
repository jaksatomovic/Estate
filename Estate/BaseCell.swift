//
//  BaseCell.swift
//  Estate
//
//  Created by Jaksa Tomovic on 02/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
}

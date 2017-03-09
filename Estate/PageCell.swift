//
//  PageCell.swift
//  Estate
//
//  Created by Jaksa Tomovic on 02/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    
    
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            let imageName = page.imageName
            
//            if UIDevice.current.orientation.isLandscape {
//                imageName += "_landscape"
//                shadowLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.17).isActive = true
//            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.darkGray]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
            
        }
    }

    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SOME SAPLE TEXT"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        return tv
    }()
    
    let shadowLine: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Base")
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(textView)
        addSubview(shadowLine)
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        shadowLine.anchorToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        shadowLine.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    }
}

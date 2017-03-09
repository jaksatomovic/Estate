
//
//  LoginCell.swift
//  JTWalkthrough
//
//  Created by Jaksa Tomovic on 27/02/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Estate"
        tv.isSelectable = false
        return tv
    }()
    
    let emailTextField: CustomTextField = {
        let tv = CustomTextField()
        tv.leftImage = UIImage(named: "ico-email")
        tv.setBottomBorder()
        tv.placeholder = "Email"
        tv.keyboardType = .emailAddress
        return tv
    }()
    
    let passwordTextField: CustomTextField = {
        let tv = CustomTextField()
        tv.setBottomBorder()
        tv.leftImage = UIImage(named: "ico-lock")
        tv.placeholder = "Password"
        tv.rightViewMode = .always
        tv.isSecureTextEntry = true
        return tv
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register here", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    
    lazy var labelQuestion: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    weak var delegate: WelcomeController?
    
    func handleLogin() {
        delegate?.finishLoggingIn()
    }
    
    func handleRegistration() {
        delegate?.goToRegisterPage()
    }
       
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(labelQuestion)
        addSubview(registerButton)
        
        setText()
        
      
        
        _ = textView.anchor(centerYAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: -220, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: frame.width, heightConstant: 160)
        
        
        _ = emailTextField.anchor(textView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)       
        
        
        _ = registerButton.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 12, rightConstant: 32, widthConstant: 0, heightConstant: 26)
        
        _ = labelQuestion.anchor(nil, left: leftAnchor, bottom: registerButton.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 26)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setText() {
    
        let color = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        
        let attributedText = NSMutableAttributedString(string: "ESTATE", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 25, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
        
        attributedText.append(NSAttributedString(string: "\n\nHello There!", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16), NSForegroundColorAttributeName: UIColor.darkGray]))
        
        attributedText.append(NSAttributedString(string: "\n\nSign in to access your account.", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.characters.count
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
        
    }
    
}


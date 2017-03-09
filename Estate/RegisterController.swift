//
//  RegisterController.swift
//  Estate
//
//  Created by Jaksa Tomovic on 03/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SOME SAMPLE TEXT"
        tv.isSelectable = false
        return tv
    }()
    
    let fullNameTextField: CustomTextField = {
        let tv = CustomTextField()
        tv.leftImage = UIImage(named: "icon-profile")
        tv.setBottomBorder()
        tv.placeholder = "Full Name"
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
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    lazy var linkedinButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.setImage(UIImage(named: "linked-in"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -(self.view.frame.size.width/3.5), 0, 0)
        button.setTitle("Sign up with LinkedIn", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 52/255, green: 109/255, blue: 166/255, alpha: 1)
        button.addTarget(self, action: #selector(signInWithLinkedin), for: .touchUpInside)
        return button
    }()
    
    lazy var termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(showTerms), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ico-close"), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(cancelRegistration), for: .touchUpInside)
        return button
    }()
    
    func showTerms() {print("not availbale yet")}
    
    func handleRegistration() {
        let homeScreen = CustomTabBarController()
        present(homeScreen, animated: true, completion: nil)
    }
    
    func signInWithLinkedin() {
        
        let banner = Banner(title: "Registration Failed", subtitle: "This is not available yet", image: UIImage(named: "ico-close"), backgroundColor: UIColor.red)
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
    }
    
    func cancelRegistration() {
        dismiss(animated: true, completion: nil)
    }
    
    var closeButtonTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        view.addSubview(closeButton)
        view.addSubview(textView)
        view.addSubview(fullNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(linkedinButton)
        view.addSubview(termsButton)
        
        observeKeyboardNotifications()
        setText()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        closeButtonTopConstraint = closeButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 34, heightConstant: 34).first
        
        _ = textView.anchor(view.centerYAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: -220, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: view.frame.width, heightConstant: 140)
        
        _ = fullNameTextField.anchor(textView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = emailTextField.anchor(fullNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = registerButton.anchor(passwordTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = linkedinButton.anchor(registerButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 46)
        
        _ = termsButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 46)
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -80 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            self.closeButtonTopConstraint?.constant = -10
            
        }, completion: nil)
    }
    
    func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.closeButtonTopConstraint?.constant = 24
            
        }, completion: nil)
    }
    
    
    fileprivate func setText() {
        
        
        let attributedText = NSMutableAttributedString(string: "New account,", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 25, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\nLinkedin sign-up are verified with blabla next their brinding.", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let length = attributedText.string.characters.count
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
        
    }
    
}

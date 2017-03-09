//
//  WelcomeController.swift
//  Estate
//
//  Created by Jaksa Tomovic on 02/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.setTitleColor(UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skipToLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    func nextPage() {
        if pageControl.currentPage == pages.count {return}
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
        }
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    func skipToLogin(){
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    fileprivate func moveControlConstraintsOffScreen() {
        self.pageControlBottomAnchor?.constant = 40
        self.skipButtonBottomAnchor?.constant = 40
        self.nextButtonBottomAnchor?.constant = 40
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }

    
    let pages: [Page] = {
    
        let firstPage = Page(title: "Explore", message: "Explore real estate in your neighboarhood or accross the world in real time", imageName: "Onboarding-1")
        let secondPage = Page(title: "Be an Agent", message: "At every moment you can tell if the vibration that you are sending is either a positive one or a negative", imageName: "Onboarding-2")
        let thirdPage = Page(title: "Be a Buyer", message: "When you type the website name on your address bar, a simple yet classy homepage of the website", imageName: "Onboarding-3")
        let fourthPage = Page(title: "Be a Seller", message: "Did you read the DaVinci Code or maybe see the movie? Did it get you interested in history and secret codes?", imageName: "Onboarding-4")
        let fifthPage = Page(title: "Neighboarhood Influancer", message: "Gain followers, likes and rise a neighboarhood influancer.", imageName: "Onboarding-5")
        let sixthPage = Page(title: "Message", message: "Follow, like or direct message post that spark your interest.", imageName: "Onboarding-6")
        
        return [firstPage, secondPage, thirdPage, fourthPage, fifthPage, sixthPage]
    
    }()
 
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"

    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonBottomAnchor: NSLayoutConstraint?
    var nextButtonBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        self.view.addSubview(collectionView)
        self.view.addSubview(pageControl)
        self.view.addSubview(skipButton)
        self.view.addSubview(nextButton)
        
        skipButtonBottomAnchor = skipButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50)[1]
        
        nextButtonBottomAnchor = nextButton.anchor(nil, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: skipButton.rightAnchor, bottom: view.bottomAnchor, right: nextButton.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)

        registerCells()
        
    }

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = targetContentOffset.pointee.x / view.frame.width
        pageControl.currentPage = Int(pageNumber)
        
        if pageNumber == CGFloat(pages.count) {
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonBottomAnchor?.constant = 0
            nextButtonBottomAnchor?.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
        
    }
    
    
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            nextButton.setTitle("LOGIN", for: .normal)
            return loginCell
        }else {nextButton.setTitle("NEXT", for: .normal)}
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainTabBarController = rootViewController as? CustomTabBarController else {
            return
        }
        mainTabBarController.viewControllers = [HomeController()]
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func goToRegisterPage() {
        let registerScreen = RegisterController()
        present(registerScreen, animated: true, completion: {
            //perhaps later
        })
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        //scroll to indexPath after rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
}













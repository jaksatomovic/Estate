//
//  CustomTabBarController.swift
//  Estate
//
//  Created by Jaksa Tomovic on 03/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(red: 59/255, green: 124/255, blue: 236/255, alpha: 1)
        
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem.image = UIImage(named: "Home")
        homeController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let discoverController = UINavigationController(rootViewController: UIViewController())
        discoverController.tabBarItem.image = UIImage(named: "icon-discover")
        discoverController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let postController = UINavigationController(rootViewController: UIViewController())
        postController.tabBarItem.image = UIImage(named: "Photo")
        postController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let messageController = UINavigationController(rootViewController: UIViewController())
        messageController.tabBarItem.image = UIImage(named: "icon-message")
        messageController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        let profileController = UINavigationController(rootViewController: ProfileController())
        profileController.tabBarItem.image = UIImage(named: "Profile")
        profileController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        
        if isLoggedIn() {
            viewControllers = [homeController,discoverController,postController,messageController,profileController]
        }else {
            perform(#selector(showWelcomeController), with: nil, afterDelay: 0.01)
        }
        
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func showWelcomeController() {
        let welcomeScreen = WelcomeController()
        present(welcomeScreen, animated: true, completion: {
            //perhaps later
        })
    }
}

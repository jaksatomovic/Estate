//
//  ProfileController.swift
//  Estate
//
//  Created by Jaksa Tomovic on 05/03/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        view.backgroundColor = .white
        
    }
    
    func handleSignOut() {
        
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let welcomeController = WelcomeController()
        present(welcomeController, animated: true, completion: nil)
    }

}

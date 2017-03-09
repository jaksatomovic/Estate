//
//  UserDefaults+Helpers.swift
//  JTWalkthrough
//
//  Created by Jaksa Tomovic on 27/02/17.
//  Copyright © 2017 Jaksa Tomovic. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
    }

    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}

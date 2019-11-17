//
//  UserInfo.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 17/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation

struct UserInfo {
    let firstName: String
    let lastName: String
    let age: Int
    let profilePicture: String
    let email: String
    
    init(firstName: String, lastName: String, age: Int, profilePicture: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.profilePicture = profilePicture
        self.email = email
    }
}

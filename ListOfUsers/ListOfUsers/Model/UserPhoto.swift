//
//  UserImage.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 17/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation

struct UserPhoto {

    let url: String

    init(info: [String: Any]) {
        
        self.url = info["photoURL"] as! String
    }

}

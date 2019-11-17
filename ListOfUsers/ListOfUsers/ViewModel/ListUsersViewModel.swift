//
//  ListUsersViewModel.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation

class ListUsersViewModel {
    
     var userList: [Results]
    
     init(complition: @escaping () -> ()) {
        userList = [Results]()
        
        ApiRequests.shared.fetchResponseModel() { [weak self] data in
            self?.userList = data.results
            complition()
        }
    }
}

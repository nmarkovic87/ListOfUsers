//
//  ListUsersViewModel.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation

/// Class ListUsersViewModel 
class ListUsersViewModel {
    
    /// Array for storing list of users
    private var userList: [Results] = [Results]()
        
    public func fetchUserList(complition: @escaping () -> ()) {
        
        //Start pulling JSON data from specific URL
        ApiRequests.shared.fetchResponseModel() { [weak self] data in
            self?.userList = data.results
            complition()
        }
    }
    /// Check if user list array is empty
    public func isUserListEmpty() -> Bool {
       return self.userList.count > 0
    }
    
    /// Get user list
    public func getUserList() -> [Results] {
        return self.userList
    }
}

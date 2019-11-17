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
        
        ApiRequests().fetchResponseModel() { [weak self] data in
            self?.userList = data.results
            complition()
        }
    }
    
    func flag(from country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}

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

    func getFlag(from country:String) -> String {
        let base : UInt32 = 127397
        var flagString = ""
        for v in country.uppercased().unicodeScalars {
            flagString.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flagString
    }
    
    func getFullName(_ firstName:String, _ lastName:String) -> String {
           return [firstName, lastName].compactMap{ $0 }.joined(separator: " ")
    }
}

//
//  ApiRequests.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation
import Alamofire

/// Class for managing api requests for site https://randomuser.me

class ApiRequests {
    
    static let shared = ApiRequests()
    
    /// Constant URL link for gettings JSON from REST API
    private static let LINK = "https://randomuser.me/api?page=1&results=20"
    
    
    /// Fetch JSON from current link
    /// - Parameter completion: ResponseModel
    func fetchResponseModel(completion: @escaping (ResponseModel) -> Void) {
        Alamofire.request(URL(string:ApiRequests.LINK)!,
                          method: .get,
                          parameters: nil)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(ResponseModel.self, from: data)
                        print(jsonData)
                        completion(jsonData)
                    }catch let decodingError {
                        print(decodingError)
                    }
                    
                case .failure(let error):
                    print("Failed to retreive JSON from link. Error: \(error)")
                }
        }
    }
}

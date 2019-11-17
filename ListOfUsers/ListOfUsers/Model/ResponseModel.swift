//
//  User.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation

/// ResponseModel - Represent JSON data pulled from server

struct ResponseModel: Codable{
    enum CodingKeys: String, CodingKey{
        case results
        case info
    }
    
    let results: [Results]
    let info: Info
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try values.decode([Results].self, forKey:.results)
        self.info = try values.decode(Info.self, forKey: .info)
    }
}

struct Results: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone: String
    let cell: String
    let id: Id
    let picture: Picture
    let nat: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
    let postcode: String
    let coordinates: Coordinates
    let timezone: Timezone
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try values.decode(Street.self, forKey:.street)
        self.city = try values.decode(String.self, forKey: .city)
        self.state = try values.decode(String.self, forKey: .state)
        self.country = try values.decode(String.self, forKey: .country)
        self.coordinates = try values.decode(Coordinates.self, forKey: .coordinates)
        self.timezone = try values.decode(Timezone.self, forKey: .timezone)
        
        if let value = try? values.decode(Int.self, forKey: .postcode) {
            self.postcode = String(value)
        } else {
            self.postcode = try values.decode(String.self, forKey: .postcode)
        }
    }
}

struct Street: Codable {
    let number : Int
    let name : String
}

struct Coordinates: Codable {
    let latitude : String
    let longitude : String
}

struct Timezone: Codable {
    let offset : String
    let description : String
}

struct Login: Codable {
    let username: String
    let password : String
    let salt : String
    let md5 : String
    let sha1 : String
    let sha256 : String
}

struct Dob: Codable {
    let date : String
    let age : Int
}

struct Registered: Codable {
    let date: String
    let age: Int
}

struct Id: Codable {
    let name: String
    let value: String?
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Info: Codable {
    let seed: String
    let results : Int
    let page : Int
    let version : String
}

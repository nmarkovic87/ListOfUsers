//
//  ListOfUsersTests.swift
//  ListOfUsersTests
//
//  Created by Nemanja Markovic on 18/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import XCTest
@testable import ListOfUsers

class ListOfUsersTests: XCTestCase {

     let viewModel = ListUsersViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingUserListFromURL() {
       
        let promise = expectation(description: "Fetch Data")
        
        viewModel.fetchUserList( complition: {
            XCTAssertGreaterThan(self.viewModel.getUserList().count, 0)
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 5){ error in
            
        }
    }
    
    func testIsUserListIsEmpty() {
       
        let promise = expectation(description: "Fetch Data")
        
        viewModel.fetchUserList( complition: {
            XCTAssert(self.viewModel.isUserListEmpty(), "User list is not empty")
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 5){ error in
            
        }
    }
    
    func testUserInfoIsNotNil(){
        
        let userInfo = UserInfo(firstName: "Alicia", lastName: "Richard", age: 40, profilePicture: "https://randomuser.me/api/portraits/women/92.jpg", email: "alicia.richard@example.com")
        XCTAssertNotNil(userInfo)
    }
}

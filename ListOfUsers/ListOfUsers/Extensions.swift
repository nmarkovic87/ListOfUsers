//
//  Extensions.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 17/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation
import UIKit

extension UInt64 {

    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}

extension UIImageView {
    func updateCornerRadius() {
        let radius = self.frame.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension String {
    func addNewString(_ new:String) -> String {
           return [self, new].compactMap{ $0 }.joined(separator: " ")
    }
    
    func getFlagFromString() -> String {
           let base : UInt32 = 127397
           var flagString = ""
           for v in self.uppercased().unicodeScalars {
               flagString.unicodeScalars.append(UnicodeScalar(base + v.value)!)
           }
           return flagString
    }
}


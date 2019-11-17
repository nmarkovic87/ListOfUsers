//
//  Extensions.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 17/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import Foundation
import UIKit

/// Extension for UInt64 type
extension UInt64 {
    
    /// Get megabytes from current value
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}
/// Extension for UIImageView type
extension UIImageView {
    /// Creating corner radius on image view
    func updateCornerRadius() {
        let radius = self.frame.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

/// Extension for String type
extension String {
    /// Add new string on current
    func addNewString(_ new:String) -> String {
        return [self, new].compactMap{ $0 }.joined(separator: " ")
    }
    /// Get flag emoji from string
    func getFlagFromString() -> String {
        let base : UInt32 = UInt32(Constants.BASE_SIZE)
        var flagString = ""
        for v in self.uppercased().unicodeScalars {
            flagString.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flagString
    }
}


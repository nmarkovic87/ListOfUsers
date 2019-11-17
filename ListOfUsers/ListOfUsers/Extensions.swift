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


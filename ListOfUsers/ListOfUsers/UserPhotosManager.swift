//
//  UserPhotosManager.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 17/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotosManager {

    static let shared = PhotosManager()

    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
        }
    }
    
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }

    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
}

//
//  UserTableViewCell.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import UIKit
import Alamofire

///Custom table view cell class with information about user
class UserTableViewCell: UITableViewCell {
    
    var photosManager: PhotosManager { return .shared }
    var request: Request?
    var photo: UserPhoto!
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var firstAndLastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbnailImage.updateCornerRadius()
    }
    
}
///Custom table view cell extension
extension UserTableViewCell {
    
    /// Load avatar image in user cell
    /// - Parameter url: url for downloading avatar image
    func loadAvatarImage(_ url:String) {
        removePicture()
        loadPicture(url)
    }
    
    /// Remove avatar image from user cell
    func removePicture() {
        thumbnailImage.image = nil
        request?.cancel()
    }
    
    /// Load cached image
    /// - Parameter url: URL for avatar image
    func loadPicture(_ url:String) {
        if let image = photosManager.getCachedImage(for: url) {
            populateCellAvatarWithPicture(with: image)
            return
        }
        downloadPicture(url)
    }
    
    /// Download avatar image from server
    /// - Parameter url: URL for image
    func downloadPicture(_ url:String) {
        loadingIndicator.startAnimating()
        request = photosManager.retrieveImage(for: url) { image in
            self.populateCellAvatarWithPicture(with: image)
        }
    }
    
    /// Populate image view in cell
    /// - Parameter image: current image avatar
    func populateCellAvatarWithPicture(with image: UIImage) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        thumbnailImage.image = image
    }
}

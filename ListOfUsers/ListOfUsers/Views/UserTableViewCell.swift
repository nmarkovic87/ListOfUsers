//
//  UserTableViewCell.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import UIKit
import Alamofire

class UserTableViewCell: UITableViewCell {

    var photosManager: PhotosManager { return .shared }

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var firstAndLastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var request: Request?
    var photo: UserPhoto!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        let radius = self.thumbnailImage.frame.size.width / 2.0
        self.thumbnailImage.layer.cornerRadius = radius
        thumbnailImage.clipsToBounds = true
    }
    
    func loadAvatarImage(_ url:String) {
        reset()
        loadPicture(url)
    }

    func reset() {
        thumbnailImage.image = nil
        request?.cancel()
    }

   func loadPicture(_ url:String) {
        if let image = photosManager.cachedImage(for: url) {
            populateCellAvatarWithPicture(with: image)
            return
        }
        downloadPicture(url)
    }

    func downloadPicture(_ url:String) {
        loadingIndicator.startAnimating()
        request = photosManager.retrieveImage(for: url) { image in
            self.populateCellAvatarWithPicture(with: image)
        }
    }

    func populateCellAvatarWithPicture(with image: UIImage) {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        thumbnailImage.image = image
    }
}

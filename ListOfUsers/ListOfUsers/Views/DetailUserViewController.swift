//
//  DetailUserViewController.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 16/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import UIKit
import MessageUI
import Alamofire

class DetailUserViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    var photosManager: PhotosManager { return .shared }
    var request: Request?
    
    @IBOutlet weak var largePictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    
    var currentUserInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadAllUserInfo()
    }
    @IBAction func openMailComposer(_ sender: Any) {
        sendEmail(currentUserInfo!.email)
    }
}

extension DetailUserViewController {
    
    fileprivate func loadAllUserInfo() {
        self.largePictureImageView.updateCornerRadius()
        downloadProfilePicture(currentUserInfo!.profilePicture)
        self.fullNameLabel.text = currentUserInfo!.firstName.addNewString(currentUserInfo!.lastName)
        self.ageLabel.text = String(currentUserInfo!.age)
        self.emailButton.setTitle(currentUserInfo!.email, for: .normal)
    }
    
    func downloadProfilePicture(_ url:String) {
        request = photosManager.retrieveImage(for: url) { image in
            self.displayProfilePicture(with: image)
        }
    }
    
    func displayProfilePicture(with image: UIImage) {
        DispatchQueue.main.async{
            self.largePictureImageView.image = image
        }
    }
    
    func sendEmail(_ email:String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject("New subject")
            mail.setMessageBody("<p>Best Regards, \(String(describing: currentUserInfo!.firstName)) </p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            showAlert()
        }
    }
    
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func showAlert(){
        let alertController = UIAlertController(title: "Error",
                                                     message: "Problem with composing email",
                                                     preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                  alertController.addAction(defaultAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  ListOfUsers
//
//  Created by Nemanja Markovic on 15/11/2019.
//  Copyright © 2019 nmarkovic. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController {
    
    var photosManager: PhotosManager { return .shared }
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ListUsersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnStart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel = ListUsersViewModel(complition: {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            let detailUserViewController = segue.destination as! DetailUserViewController
            let index = tableView.indexPathForSelectedRow?.row
            
            let current = viewModel.userList[index!]
            let user = UserInfo(firstName: current.name.first, lastName: current.name.last, age: current.dob.age, profilePicture: current.picture.large, email: current.email)
            
            
            detailUserViewController.currentUserInfo = user

    }
}

extension ListUsersViewController {
    func setupViewOnStart(){
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension ListUsersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}

extension ListUsersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell
        
        
        if viewModel.userList.count > 0 {
            let user = viewModel.userList[indexPath.row]
            cell?.firstAndLastNameLabel.text = user.name.first.addNewString(user.name.last)
            cell?.ageLabel.text = String(user.dob.age)
            cell?.flagLabel.text = user.nat.getFlagFromString()
            cell?.loadAvatarImage(user.picture.thumbnail)
            
        }
        return cell!
    }
 
}


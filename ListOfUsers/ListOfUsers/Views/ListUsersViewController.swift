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
    private var viewModel: ListUsersViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListUsersViewModel(complition: {
            self.refreshList()
        })
        
        setupViewOnStart()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailUserViewController = segue.destination as! DetailUserViewController
        
        guard let index = tableView.indexPathForSelectedRow?.row else {return}
        
        detailUserViewController.currentUserInfo = getCurrentSelectedUser(index)
        
    }
}

extension ListUsersViewController {
    
    /// Setup view appearance
    private func setupViewOnStart(){
        prepareNavigationBar()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    /// Prepare navigation bar
    private func prepareNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    /// Get user from array
    /// - Parameter index: index of current user
    private func getCurrentSelectedUser(_ index:Int) -> UserInfo{
        let current = viewModel.getUserList()[index]
        return  UserInfo(firstName: current.name.first, lastName: current.name.last, age: current.dob.age, profilePicture: current.picture.large, email: current.email)
    }
    
    /// Refresh user list
    private func refreshList(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}

extension ListUsersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Constants.CELL_HEIGHT)
    }
}

extension ListUsersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getUserList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_INDETIFIER) as? UserTableViewCell
        
        if viewModel.getUserList().count > 0 {
            
            let user = viewModel.getUserList()[indexPath.row]
            cell?.firstAndLastNameLabel.text = user.name.first.addNewString(user.name.last)
            cell?.ageLabel.text = String(user.dob.age)
            cell?.flagLabel.text = user.nat.getFlagFromString()
            cell?.loadAvatarImage(user.picture.thumbnail)
            
        }
        return cell!
    }
}

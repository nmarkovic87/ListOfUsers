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
        if segue.identifier == "detailUserViewController"{
            let detailUserViewController = segue.destination as! DetailUserViewController
            
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailUserViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "detailUserViewController") as? DetailUserViewController{
            if let navigator = navigationController {
                navigator.pushViewController(detailUserViewController, animated: true)
            }
        }
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
            cell?.firstAndLastNameLabel.text = viewModel.getFullName(user.name.first, user.name.last)
            cell?.ageLabel.text = String(user.dob.age)
            cell?.flagLabel.text = viewModel.getFlag(from: user.nat)
            cell?.loadAvatarImage(user.picture.thumbnail)
            
        }
        return cell!
    }
 
}


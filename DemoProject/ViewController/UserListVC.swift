//
//  ViewController.swift
//  DemoProject
//
//  Created by Padam on 15/02/20.
//  Copyright © 2020 Padam. All rights reserved.
//

import UIKit
import Alamofire;
import ObjectMapper;
import SVProgressHUD

class UserListVC: UIViewController {
    var userList : [User] = []
    var isLoading : Bool = false
    var offset : Int = 0
    var limit : Int = 10
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var tblUserView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.tblUserView.refreshControl = refreshControl
        } else {
            self.tblUserView.addSubview(refreshControl)
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(refreshUserData(_:)), for: .valueChanged)
        self.title = "Users";
        self.tblUserView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @objc private func refreshUserData(_ sender: Any) {
        // Fetch User Data
        self.offset = 0
        isLoading = true
        self.getUsers()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getUsers()
    }
    
    func getUsers(){
        if(!isLoading){
            SVProgressHUD.show(withStatus: "Loading...")
        }
        let dictParam : [String:Any] = ["offset":self.offset,"limit":10];
        let urlString = "http://sd2-hiring.herokuapp.com/api/users";
        guard let url = URL(string: urlString) else { return };
        Alamofire.request(url,parameters: dictParam).responseJSON { response in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing();
                SVProgressHUD.dismiss()
                self.isLoading = false
                let dictRes = response.result.value as? [String:Any]
                let dictData = dictRes?["data"] as? [String:Any]
                let arrData = dictData?["users"] as? [[String:Any]] ?? []
                let arrUsers = Mapper<User>().mapArray(JSONArray: arrData)
                self.userList.append(contentsOf: arrUsers)
                self.tblUserView.reloadData()
                print(arrData);
            }
        }
    }
}



extension UserListVC : UITableViewDataSource,UITableViewDelegate{
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }
    
    func configureCell(cell: UserTableViewCell, forRowAt indexPath: IndexPath) {
        let userObj = self.userList[indexPath.row]
        cell.lblName.text = userObj.name ?? ""
        cell.imgProfile.setImageFromURL(urlString: userObj.image ?? "")
        cell.imgProfile.layer.cornerRadius = 30.0
        let itemArray  = userObj.items  ?? []
        cell.arrItems = itemArray;
        cell.itemCollectionView.reloadData()
        
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !(indexPath.row + 1 < self.userList.count && self.userList.count > 0) {
            self.isLoading = true;
            self.offset = self.offset + limit;
            self.getUsers()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tblWidth : Double = Double(self.tblUserView.frame.size.width-20);
        var height = 0.0
        let items = self.userList[indexPath.row].items ?? []
        let numberOfRows = items.count / 2
        height = Double(numberOfRows) * (tblWidth/2)
        if(items.count % 2 != 0){
            height = height + tblWidth
        }
        return CGFloat(height + 80.0)
        
    }
}




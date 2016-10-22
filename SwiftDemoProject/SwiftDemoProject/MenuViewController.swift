//
//  MenuViewController.swift
//  SwiftDemo
//
//  Created by Hema on 11/10/16.
//  Copyright © 2016 Ranosys. All rights reserved.
//

import UIKit


class MenuViewController: UITableViewController {
    
   var sideBarArray: [String] = ["Profile", "EditProfile", "Logout"]
    @IBOutlet var menuBarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        self.revealViewController().frontViewController.view.isUserInteractionEnabled=false
        menuBarTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.01;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sideBarArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: sideBarArray[indexPath.row], for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         if indexPath.row==2 {
            //Logout
            UserDefaults.standard.setValue(nil, forKey: "userEmail")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let loginView = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            UIApplication.shared.keyWindow?.rootViewController = loginView
        }
        tableView .reloadData()
    }
    // MARK: - end
}

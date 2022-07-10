//
//  AlertListViewController.swift
//  DrinkWater
//
//  Created by Lena on 2022/07/10.
//

import UIKit
 
class AlertListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
    }
    
}

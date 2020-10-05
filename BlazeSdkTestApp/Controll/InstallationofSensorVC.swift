//
//  InstallationofSensorVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 30/09/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class InstallationofSensorVC: UIViewController {
    
    
    @IBOutlet weak var tblVw_Sensors: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

    @IBAction func acn_backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//          return 10
//      }
    
   
}

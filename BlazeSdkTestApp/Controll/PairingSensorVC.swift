//
//  PairingSensorVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 30/09/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class PairingSensorVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func acn_backBtnj(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

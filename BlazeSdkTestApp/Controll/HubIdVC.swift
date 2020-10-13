//
//  HubIdVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 12/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubIdVC: UIViewController {
    
    @IBOutlet weak var tf_HubID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func acn_NextBtn(_ sender: Any) {
        
       // callApiForAddHub()
    }
    
    @IBAction func acn_BackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callApiForAddHub(){
        SystemAlert().showLoader()
        
        BlazeSdkClass.shared.addHub(hubId: "hars", hubName: "hars") { (response) in
            
        //BlazeSdkClass().addHub(hubId: "hars", hubName: "hars") { (response) in
            SystemAlert().removeLoader()
            print(response)
        } 
        
    }
}

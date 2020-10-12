//
//  WifiPasswordVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 12/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class WifiPasswordVC: UIViewController {
    
    
    @IBOutlet weak var tf_Ssid: UITextField!
    
    
    @IBOutlet weak var tf_Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func acn_SendWifiData(_ sender: Any) {
        
        callApitoSaveWifiDetails()
        
    }
    
    func callApitoSaveWifiDetails()
    {
        
        BlazeSdkClass.shared.sendWifiCredentials(ssid: "123456", password: "test", hubId: "hars") { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                SystemAlert().removeLoader()
               // self.pushToController(with: .hubAdditionVCStep3, inStoryboard: .main)
            }else{
                SystemAlert().removeLoader()
                // connect again and check background hub is connected or not
            }
        }
    }
    
}

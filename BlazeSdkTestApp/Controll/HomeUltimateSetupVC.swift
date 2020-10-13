//
//  HomeUltimateSetupVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 30/09/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import Alamofire

class HomeUltimateSetupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func acn_backBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func acn_nextBtn(_ sender: Any) {
        
        callApiForHubInstallation()
    }
    
    
    func callApiForHubInstallation(){
        
        let dict = ["installerId": "iOS"] as [String : Any]
        
        // https://api.dev.datadrivencare.net/hubs/C44F33354375/installation
        
        Webservices.instance.postMethod(connectionInfo.SERVER_URL + apiMethod.hubInstallation , param: dict) { (status, response) in
            if(status == true){
                
                SystemAlert().basicActionAlert(withTitle: "", message: "Hub Installed Successfully", actions: [.okAlert]) { (alert) in
     
                }
                
            }
        }
    }

}

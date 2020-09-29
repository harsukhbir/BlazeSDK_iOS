//
//  ViewController.swift
//  BlazeSdkTest
//
//  Created by Ram on 01/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class IntialVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        LocationServices.shared.start { (locationInfo) in
            
        }

        if(TestUtility().extractLoginDetails().allKeys.count > 1){
             BlazeClient.shared.userId = TestUtility().extractLoginDetails()["user_id"] as! String
             BlazeClient.shared.emailId = "" // user email id
                        
            if (TestUtility().extractTokenDetails().allKeys.count > 1) {
                BlazeClient.shared.accesToken =  TestUtility().extractTokenDetails()["access_token"] as! String
              //  self.pushToController(with: .homeVC, inStoryboard: .main)
               
                debugPrint(TestUtility().extractTokenDetails()["access_token"] as! String)
                
                if TestUtility().extractHubDetails().allKeys.count > 1 {
                    
                    let Response = TestUtility().extractHubDetails()
                     TestUtility().setSelectedHubId(hubId: ((Response["data"] as! NSArray)[0] as! NSDictionary)["hub_id"] as! String)
                    
                    self.pushToController(with: .homeVC, inStoryboard: .main)
                }else{
                    self.pushToController(with: .hubScannedListVC, inStoryboard: .main)
                }
            }
            
            
        }
        
        

    }
    
    
    
    @IBAction func clickOnloginBtn(_ sender: Any) {
        self.pushToController(with: .loginVC, inStoryboard: .main)
        
    }
   
    @IBAction func clickOnRegisterBtn(_ sender: Any) {
        self.pushToController(with: .registerVC, inStoryboard: .main)
    }
    
}


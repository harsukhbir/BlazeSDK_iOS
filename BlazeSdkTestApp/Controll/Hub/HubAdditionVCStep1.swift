//
//  HubAdditionViewController.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk
import SystemConfiguration.CaptiveNetwork
import CoreLocation


class HubAdditionVCStep1: UIViewController, BlazeResponseManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        BlazeSdkClass.shared.delegate = self
        self.title = "Hub addition step 1"
       
    }
    
    @IBAction func clickOnNextButton(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass().connectHub(hubId:  TestUtility().getAddingHubId()) { (Response) in
            SystemAlert().removeLoader()
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                self.pushToController(with: .hubAdditionVCStep2, inStoryboard: .main)
            }
                //15Oct 2020
            else{
                 self.pushToController(with: .hubAdditionVCStep2, inStoryboard: .main)
            }
        }
        
//        SystemAlert().showLoader()
//        BlazeSdkClass.shared.checkHubStatus(hubId: constants().hubID) { (status) in
//            SystemAlert().removeLoader()
//            if(status == true){
//               //  self.pushToController(with: .homeVC, inStoryboard: .main)
//                // call add hub api
//            }
//        }
    }
    func readResponse(response: NSDictionary) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

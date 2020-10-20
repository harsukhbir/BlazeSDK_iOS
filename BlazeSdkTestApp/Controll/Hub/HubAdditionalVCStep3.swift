//
//  HubAdditionalVCStep3.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 13/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubAdditionalVCStep3: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var hubStatusLable: UILabel!
    @IBOutlet weak var disLbl: UILabel!
    var vcFrom = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hubStatusLable.text = "Current status : Offline"
        //15 Oct 2020
//        nextButton.alpha = 0.5
//        nextButton.isUserInteractionEnabled = false
        if(vcFrom == "change_access"){
            self.title = "Check hub status"
            self.disLbl.text = "Go to settings and  connect to your home Wi-Fi network and click on 'check hub status button'. If the Hub come's online then 'Home' button will be enabled. \nNote : If Hub LED blinks in BLUE, internet may not be available.If Hub LED blinks RED, Hub can not connect to the Preferred Wi-Fi with given credentials. Then do change access point again. "
            nextButton.setTitle("Home", for: .normal)
        }else{
            self.title = "Hub addition step 3"
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnCheckHubStatus(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.checkHubStatus(hubId: TestUtility().getAddingHubId()) { (status) in
            debugPrint(status)
            SystemAlert().removeLoader()
            if(status){
                self.hubStatusLable.text = "Current status : Online"
                self.nextButton.alpha = 1
                self.nextButton.isUserInteractionEnabled = true
            }
        }
    }
    @IBAction func clickOnNextButton(_ sender: Any) {
        if(vcFrom == "change_access"){
            
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: HomeVC.self) {
                    self.navigationController?.popToViewController(controller, animated: true)
                }
                
            }
            
        }else{
            self.pushToController(with: .hubAdditionVCStep4, inStoryboard: .main)
        }
        
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

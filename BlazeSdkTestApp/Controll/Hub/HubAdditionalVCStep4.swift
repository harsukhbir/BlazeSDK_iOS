//
//  HubAdditionalVCStep4.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubAdditionalVCStep4: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var hubNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hub addition step 4"
        
    }
    
    @IBAction func clickOnAddHubBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.addHub(hubId: TestUtility().getAddingHubId(), hubName: hubNameTF.text ?? "Test Hub") { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                self.getHubDetails()
            }else{
                SystemAlert().removeLoader()
            }
            
        }
        
       
    }
    
    func getHubDetails() {
        BlazeSdkClass.shared.getHubDetails { (Response) in
            SystemAlert().removeLoader()
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                TestUtility().saveHubDetails(req : Response)
                self.pushToController(with: .homeVC, inStoryboard: .main)
            }
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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

//
//  PairDeviceVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 18/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class PairDeviceVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var noidIdLbl: UILabel!
    @IBOutlet weak var boneIdLbl: UILabel!
    @IBOutlet weak var deviceNameTF: UITextField!
    @IBOutlet weak var pairDevicebtn: UIButton!
    @IBOutlet weak var addDeviceBtn: UIButton!
    var catType: String!
    var deviceTypeName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = deviceTypeName
        addDeviceBtn.isEnabled = false
        addDeviceBtn.alpha = 0.5

        // Do any additional setup after loading the view.
    }
    @IBAction func clickOnPairDeviceBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.pairDevice(hubId: TestUtility().getSelectedHubId(), catType: catType, deviceType: "ZIGBEE") { (Response) in
           SystemAlert().removeLoader()
            if(Response["status"] as! Bool){
                 
                self.noidIdLbl.text = (Response["node_id"] as! String)
                self.boneIdLbl.text = (Response["device_b_one_id"] as! String)
                self.addDeviceBtn.isEnabled = true
                self.addDeviceBtn.alpha = 1
                self.pairDevicebtn.isEnabled = false
                self.pairDevicebtn.alpha = 0.5
            }else{
            }
        }
    
    }
   
    @IBAction func clickOnAddDeviceButton(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.addDevice(hubId: TestUtility().getSelectedHubId(), catType: catType, deviceType: "ZIGBEE", deviceName: deviceNameTF.text!, nodeId: self.noidIdLbl.text!, b_OneId: self.boneIdLbl.text!) { (Response) in
            SystemAlert().removeLoader()
            if(Response["status"] as! Bool){
                
                SystemAlert().basicNonActionAlert(withTitle: "", message: "Device Added Successfully", alert: .doneAlert)
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: HomeVC.self) {
                        self.navigationController?.popToViewController(controller, animated: true)
                    }
                    
                }
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

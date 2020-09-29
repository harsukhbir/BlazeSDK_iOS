//
//  SettingsVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 13/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class SettingsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
    @IBOutlet weak var settingsTableView: UITableView!
    var settingsList : [String] = ["Reset all Zigbee devices","Delete hub","Change access point", "Enable ble list"]
    let cellReuseIdentifier = "cell"
     let listCellReuseIdentifier = "listCell"
    var hubStatus = true
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
      settingsTableView.register(UINib.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: listCellReuseIdentifier)
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        SystemAlert().showLoader()
        BlazeSdkClass.shared.checkHubStatus(hubId: TestUtility().getSelectedHubId()) { (status) in
            SystemAlert().removeLoader()
            self.hubStatus = status
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == settingsList.count-1){
             let cell = settingsTableView.dequeueReusableCell(withIdentifier: listCellReuseIdentifier, for: indexPath) as! ListCell
            
             cell.headerLbl.text = settingsList[indexPath.row]
            cell.enableSwitch.addTarget(self, action: #selector(enabeSwitch(_:)), for: .valueChanged)
            cell.enableSwitch.isOn = TestUtility().isEnableBleList()
            return cell
            
        }else{
            var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
                   cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
                   cell.textLabel?.text = settingsList[indexPath.row]
                   return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(settingsList[indexPath.row] == "Delete hub"){
            SystemAlert().showLoader()
            BlazeSdkClass.shared.getOtpToDeleteHub(hubId: TestUtility().getSelectedHubId()) { (Response) in
                debugPrint(Response)
                SystemAlert().removeLoader()
                if((Response["status"] as! Bool) == true){
                    self.deleteHub(code: Response["code"] as! String)
                }else{
                
                    // retry here
                }
                
            }
        }
        else if (settingsList[indexPath.row] == "Reset all Zigbee devices"){
             SystemAlert().showLoader()
            if(hubStatus == true){
                BlazeSdkClass.shared.deleteAllDevices(hubId: TestUtility().getSelectedHubId(), deviceType: "ZIGBEE") { (Response) in
                    SystemAlert().removeLoader()
                    debugPrint(Response)
                }
            }else{
                BlazeSdkClass.shared.forceDeleteAllDevices(hubId: TestUtility().getSelectedHubId(), deviceType: "ZIGBEE") { (Response) in
                    SystemAlert().removeLoader()
                    debugPrint(Response)
                }
            }
            
        }
        else if (settingsList[indexPath.row] == "Change access point"){
            let nextVC =  self.getViewController(with: .changeAccessPointVC, inStoryboard: .main) as! ChangeAccessPointVC
             nextVC.type = (hubStatus == true ? "1" : "0")
            if(hubStatus == true){
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                SystemAlert().basicActionAlert(withTitle: "", message: "Your hub seems to be offline. Connect Home-Ultimate(\(TestUtility().getSelectedHubId())) wifi in settings and click continue", actions: [.cancelAlert,.continueAlert]) { (alertType) in
                    if(alertType == .continueAlert){
                        BlazeSdkClass.shared.connectHub(hubId: TestUtility().getSelectedHubId()) { (reponce) in
                            debugPrint(reponce)
                            if(reponce["status"] as! Bool){
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }
                        }
                    }
                }
            }
    
        }
    }

    
    func deleteHub(code : String) {
        var otpStr = ""
        
        self.showAlertWithTextField(title: "Delete otp", message: "Check mail and enter otp", placeholder: "otp") { (otp) in
            if(otp.count < 5){
                debugPrint("enter valid otp")
                return
            }
            otpStr = otp
            SystemAlert().showLoader()
            
            if(self.hubStatus == true){
                BlazeSdkClass.shared.deleteHub(hubId: TestUtility().getSelectedHubId(), otp: otpStr, code: code) { (Response) in
                    debugPrint("Delete hub -->",Response)
                    if((Response["status"] as! Bool) == true){
                        SystemAlert().removeLoader()
                        TestUtility().clearAllDetails()
                        self.moveBackToController(IntialVC.self)
                    }
                    else{
                        BlazeSdkClass.shared.forceDeleteHub(hubId: TestUtility().getSelectedHubId(), otp: otpStr, code: code) { (Response) in
                            SystemAlert().removeLoader()
                            if((Response["status"] as! Bool) == true){
                                
                                TestUtility().clearAllDetails()
                                
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: IntialVC.self) {
                                        TestUtility().clearAllDetails()
                                        self.navigationController?.popToViewController(controller, animated: true)
                                    }
                                    
                                }
                                
                                
                            }else{
                                
                                // failed to delete hub
                            }
                        }
                    }
                }
                
            }else{
                BlazeSdkClass.shared.forceDeleteHub(hubId: TestUtility().getSelectedHubId(), otp: otpStr, code: code) { (Response) in
                    SystemAlert().removeLoader()
                    if((Response["status"] as! Bool) == true){
                        TestUtility().clearAllDetails()
                        
                        for controller in self.navigationController!.viewControllers as Array {
                            if controller.isKind(of: IntialVC.self) {
                                TestUtility().clearAllDetails()
                                self.navigationController?.popToViewController(controller, animated: true)
                            }
                            
                        }
                        
                        
                    }else{
                        // failed to delete hub
                    }
                }
            }
            
            
        }
        
    }
    
    @objc func enabeSwitch(_ sender : UISwitch){
        if(sender.isOn){
    
            self.showAlertWithTextField(title: "Enable time", message: "Enter time", placeholder: "Enter time", text: nil) { (timeText) in
                BlazeSdkClass.shared.enableBleDeviceList(hubID: TestUtility().getSelectedHubId(), status: true, time: Int(timeText)) { (Response) in
                     SystemAlert().showLoader()
                    debugPrint(Response)
                    SystemAlert().removeLoader()
                    if((Response["status"] as! Bool) == true){
                        TestUtility().enableBleList(status: true)
                    }else{
                        sender.isOn = false
                    }
                    SystemAlert().basicNonActionAlert(withTitle: "", message: Response["message"] as! String, alert: .okAlert)
                }
            }
        }else{
            SystemAlert().showLoader()
            BlazeSdkClass.shared.enableBleDeviceList(hubID: TestUtility().getSelectedHubId(), status: false, time: nil) { (Response) in
                 SystemAlert().removeLoader()
                if((Response["status"] as! Bool) == true){
                    TestUtility().enableBleList(status: false)
                }else{
                    sender.isOn = true
                }
                SystemAlert().basicNonActionAlert(withTitle: "", message: Response["message"] as! String, alert: .okAlert)
            }
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

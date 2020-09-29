//
//  DeviceInternalVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 18/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class DeviceInternalVC: UIViewController,BlazeResponseManagerDelegate {
    
    @IBOutlet weak var deviceNameBtn: UIButton!
    var deviceObject = NSDictionary()
    var deviceStatusObject = NSMutableDictionary()
    @IBOutlet weak var deviceStatus: UILabel!
    var hubStatus = true

    override func viewDidLoad() {
        super.viewDidLoad()

        BlazeSdkClass.shared.delegate = self
        deviceNameBtn.setTitle(deviceObject["device_name"] as? String, for: .normal)
        
        SystemAlert().showLoader()
        BlazeSdkClass.shared.checkHubStatus(hubId: TestUtility().getSelectedHubId()) { (status) in
            self.hubStatus = status
            self.getDeviceStatus()
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        BlazeSdkClass.shared.delegate = nil
    }
    @IBAction func clickOnDeviceNameBtn(_ sender: Any) {
        self.showAlertWithTextField(title: "Update device name", message: "Enter device name to update", placeholder: "device name",text: deviceObject["device_name"] as? String) { (deviceName) in
            if(deviceName.count > 0){
                SystemAlert().showLoader()
                BlazeSdkClass.shared.updateDevice(hubId: TestUtility().getSelectedHubId(), b_OneId: self.deviceObject["device_b_one_id"] as! String, deviceName: deviceName) { (Response) in
                    SystemAlert().removeLoader()
                    if((Response["status"] as! Bool) == true){
                        SystemAlert().basicNonActionAlert(withTitle: "", message: "Device name updated successfully", alert: .doneAlert)
                        self.deviceNameBtn.setTitle(deviceName, for: .normal)
                    }
                }
                
            }
        }
        
    }
    
    
    @IBAction func clickOnDeleteDeviceBtn(_ sender: Any) {
        if(hubStatus == false){
            SystemAlert().basicActionAlert(withTitle: "", message: "Your hub seems to be offline. Do you want to delete device?", actions: [.cancelAlert,.deleteAlert]) { (alert) in
                if(alert == .deleteAlert){
                    BlazeSdkClass.shared.forceDeleteDevice(hubId: TestUtility().getSelectedHubId(), b_OneId: self.deviceObject["device_b_one_id"] as! String) { (Response) in
                        SystemAlert().removeLoader()
                        if((Response["status"] as! Bool) == true){
                             SystemAlert().basicNonActionAlert(withTitle: "", message: "Device deleted successfully", alert: .doneAlert)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }else{
            SystemAlert().basicActionAlert(withTitle: "", message: "Follow the device deletion instructions on device manual, Click on 'Ok' to proceed.", actions: [.cancelAlert,.okAlert]) { (alert) in
               
                if(alert == .okAlert){
                    SystemAlert().showLoader()
                    BlazeSdkClass.shared.deleteDevice(hubId: TestUtility().getSelectedHubId(), b_OneId: self.deviceObject["device_b_one_id"] as! String, deviceType: "ZIGBEE") { (Response) in
                        if((Response["status"] as! Bool) == true){
                            
                            SystemAlert().basicNonActionAlert(withTitle: "", message: "Device deleted successfully", alert: .doneAlert)
                            
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: HomeVC.self) {
                                    self.navigationController?.popToViewController(controller, animated: true)
                                }
                                
                            }
                            
                        }else{
                            // This is force delete option
                            
                            SystemAlert().basicActionAlert(withTitle: "", message: "Your device is not responding or not in range. Do you want to delete device?", actions: [.cancelAlert,.deleteAlert]) { (alert) in
                                if(alert == .deleteAlert){
                                    SystemAlert().showLoader()
                                    BlazeSdkClass.shared.forceDeleteDevice(hubId: TestUtility().getSelectedHubId(), b_OneId: self.deviceObject["device_b_one_id"] as! String) { (Response) in
                                        SystemAlert().removeLoader()
                                        if((Response["status"] as! Bool) == true){
                                            SystemAlert().basicNonActionAlert(withTitle: "", message: "Device deleted successfully", alert: .doneAlert)
                                            self.navigationController?.popViewController(animated: true)
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        getDeviceStatus()
    }
    func getDeviceStatus() {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.getDeviceCurrentStatus(hubId: TestUtility().getSelectedHubId(), b_OneId: self.deviceObject["device_b_one_id"] as! String) { (response) in
            debugPrint(response)
            SystemAlert().removeLoader()
            if(( response["data"] as? NSDictionary) != nil){
                self.showStatusBasedOnDevice(response: response["data"] as! NSDictionary)
                self.deviceStatusObject.addEntries(from: response["data"] as! [AnyHashable : Any])
            }
        }
    }
    
    func showStatusBasedOnDevice(response : NSDictionary) {
        let categoryId : String = deviceObject["category"] as! String
                
        switch categoryId {
            case zigbeDeviceCatTypes().motionSensor:
                deviceStatus.text = (response["motion_status"] as! String  == "1" ? "Motion detected" : "Everything is ok") + "\n" + "Battery : \(response["battery_status"] as? String ?? "--")%"
            case zigbeDeviceCatTypes().doorSensor:
                deviceStatus.text = (response["door_status"] as! String  == "1" ? "Door open" : "Door close") + "\n" + "Battery : \(response["battery_status"] as? String ?? "--")%"
            case zigbeDeviceCatTypes().tempHumiditySensor:
                deviceStatus.text = "Temperature: \(response["temperature_value"] as? String ?? "--") \nHumidity : \(response["relative_humidity_value"] as? String ?? "--") \nBattery : \(response["battery_status"] as? String ?? "--")%"
            case zigbeDeviceCatTypes().sosButton:
                 deviceStatus.text =  (response["sos_status"] as? String  == "1"  ? "Button pressed" : "Everything is ok") + "\n" + "Battery : \(response["battery_status"] as? String ?? "--")%"
            default: // Hub
                if ((response["rpt"]) != nil) {
                     deviceStatus.text = "Lux : \((response["rpt"] as! NSDictionary)["lux_value"] as? String ?? "--") \nTemp : \((response["rpt"] as! NSDictionary)["temp_value"] as? String ?? "--")"
                }else{
                    deviceStatus.text = "Lux : -- \n\nTemp : --"
            }
            
               
        }
        
    }
    
    func readResponse(response: NSDictionary) {
        debugPrint(response)
        
        if(response["device_b_one_id"] as! String == self.deviceObject["device_b_one_id"] as! String){
            self.deviceStatusObject.addEntries(from: response["data"] as! [AnyHashable : Any])
             self.showStatusBasedOnDevice(response: self.deviceStatusObject)
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

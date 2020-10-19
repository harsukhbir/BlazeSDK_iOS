//
//  DeviceListViewController.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class DeviceListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var deviceTypeTableView: UITableView!
    var deviceTypeListArr:[[String:String]] = []
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceTypeTableView.tableFooterView = UIView()
        deviceTypeListArr.append(["itemLocation": "bathroom1","itemType": "motion","itemModel": "motionv1"])
        deviceTypeListArr.append(["itemLocation": "bathroom2","itemType": "motion","itemModel": "motionv1"])
        deviceTypeListArr.append(["itemLocation": "livingroom","itemType": "motion","itemModel": "motionv1"])
        deviceTypeListArr.append(["itemLocation": "hallway","itemType": "motion","itemModel": "motionv1"])
        deviceTypeListArr.append(["itemLocation": "kitchen","itemType": "motion","itemModel": "motionv1"])
        deviceTypeListArr.append(["itemLocation": "frontdoor","itemType": "door","itemModel": "doorv1"])
        deviceTypeListArr.append(["itemLocation": "backdoor","itemType": "door","itemModel": "doorv1"])
        deviceTypeListArr.append(["itemLocation": "fridge","itemType": "door","itemModel": "doorv1"])
        deviceTypeListArr.append(["itemLocation": "bathroom","itemType": "temp","itemModel": "tempv1"])
        deviceTypeListArr.append(["itemLocation": "sos","itemType": "sos","itemModel": "sosv1"])
        
        deviceTypeTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceTypeListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        let dataDict = deviceTypeListArr[indexPath.row]
        cell.textLabel?.text = dataDict["itemLocation"] ?? ""

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SystemAlert().showLoader()
        let dataDict = self.deviceTypeListArr[indexPath.row]

        BlazeSdkClass.shared.checkHubStatus(hubId: TestUtility().getSelectedHubId()) { (status) in
            
            SystemAlert().removeLoader()
            if(status){
                let nextVC =  self.getViewController(with: .pairDeviceVC, inStoryboard: .main) as! PairDeviceVC
                
                switch indexPath.row {
                    case 0:
                        nextVC.catType = zigbeDeviceCatTypes().motionSensor
                    case 1:
                        nextVC.catType = zigbeDeviceCatTypes().doorSensor
                    case 2:
                        nextVC.catType = zigbeDeviceCatTypes().tempHumiditySensor
                    case 3:
                        nextVC.catType = zigbeDeviceCatTypes().sosButton
                    default:
                        nextVC.catType = zigbeDeviceCatTypes().motionSensor
                }
                nextVC.deviceTypeName = dataDict["itemType"] ?? ""
                nextVC.deviceModelName = dataDict["itemModel"] ?? ""
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                //15 OCtober 2020
//                SystemAlert().basicNonActionAlert(withTitle: "", message: "Hub seems to be offline. You can not add devices", alert: .okAlert)
                
                let nextVC =  self.getViewController(with: .pairDeviceVCNew, inStoryboard: .main) as! PairDeviceVCNew
                 
                 switch indexPath.row {
                     case 0:
                         nextVC.catType = zigbeDeviceCatTypes().motionSensor
                     case 1:
                         nextVC.catType = zigbeDeviceCatTypes().doorSensor
                     case 2:
                         nextVC.catType = zigbeDeviceCatTypes().tempHumiditySensor
                     case 3:
                         nextVC.catType = zigbeDeviceCatTypes().sosButton
                     default:
                         nextVC.catType = zigbeDeviceCatTypes().motionSensor
                 }
                 nextVC.deviceTypeName = dataDict["itemType"] ?? ""
                 nextVC.deviceModelName = dataDict["itemModel"] ?? ""
                 nextVC.deviceLocationName = dataDict["itemLocation"] ?? ""
                 self.navigationController?.pushViewController(nextVC, animated: true)
                
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

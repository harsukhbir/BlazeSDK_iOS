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
    var deviceTypeList : [String] = ["Motion sensor", "Door sensor", "Humidity and Temperature sensor","SOS Button"]
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceTypeTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.textLabel?.text = "\(deviceTypeList[indexPath.row])"

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SystemAlert().showLoader()
        
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
                nextVC.deviceTypeName = self.deviceTypeList[indexPath.row]
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
                SystemAlert().basicNonActionAlert(withTitle: "", message: "Hub seems to be offline. You can not add devices", alert: .okAlert)
                
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

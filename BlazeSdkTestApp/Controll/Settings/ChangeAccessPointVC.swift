//
//  ChangeAccessPointVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 20/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk
protocol sendWifiName {
    func getWifiName(wifiname : String)
}

class ChangeAccessPointVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var delegate : sendWifiName? = nil
    
    @IBOutlet weak var topVwHeight: NSLayoutConstraint!
    @IBOutlet weak var accessPointTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var wifiListTableView: UITableView!
    var type = ""
    var vcType = ""
    
    
    
    var wifiList : [NSDictionary] = []
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wifiListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        

        if vcType == "add_hub" {
            type = "0"
            topVwHeight.constant = 0.0
        }
         clickOnRefreshBtn((Any).self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickOnChangeBtn(_ sender: Any) {
        SystemAlert().showLoader()
        
        BlazeSdkClass.shared.changeHubAccessPoint(hubID: TestUtility().getSelectedHubId(), type: type, ssid: accessPointTF.text!, password: passwordTF.text!) { (Response) in
            SystemAlert().removeLoader()
            print(Response)
            if(Response["status"] as! Bool){
                SystemAlert().basicActionAlert(withTitle: "", message: Response["message"] as! String, actions: [.okAlert]) { (alert) in
                    let nextVC =  self.getViewController(with: .hubAdditionVCStep3, inStoryboard: .main) as! HubAdditionalVCStep3
                    nextVC.vcFrom = "change_access"
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
    }
    
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.getWifiList(hubId: vcType == "add_hub" ? TestUtility().getAddingHubId() : TestUtility().getSelectedHubId(), type: type) { (Response) in
             SystemAlert().removeLoader()
            debugPrint(Response)
            if(Response["status"] as! Bool){
                if (Response["list"] as! NSArray).count > 0 {
                    self.wifiList = Response["list"] as! [NSDictionary]
                    self.wifiListTableView.reloadData()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wifiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
         cell.textLabel?.text = "\(wifiList[indexPath.row]["name"] as! String)"
         cell.detailTextLabel?.text = "\(wifiList[indexPath.row]["security_type"] as! String)"
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if vcType == "add_hub" {
            delegate?.getWifiName(wifiname: "\(wifiList[indexPath.row]["name"] as! String)")
            self.navigationController?.popViewController(animated: true)
        }else{
            accessPointTF.text = "\(wifiList[indexPath.row]["name"] as! String)"
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

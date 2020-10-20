//
//  HomeViewController.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var deviceListTableVw: UITableView!
    
    var addedList : [NSDictionary] = []
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var selectedhubId: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        BlazeSdkClass.shared.setHub(hubId: TestUtility().getSelectedHubId()) { (status) in
            print(status)
        }
        
        // Do any additional setup after loading the view.
        
        deviceListTableVw.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        if(TestUtility().getSelectedHubId() == ""){
             getHubDetails()
            
            
            
        }else{
            selectedhubId.text = TestUtility().getSelectedHubId()
            SystemAlert().showLoader()
            self.getDevicesList()
        }
    }
    
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        getDevicesList()
    }
    
    func getHubDetails() {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.getHubDetails { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                if(Response["data"] as! NSArray).count > 0{
                    TestUtility().setSelectedHubId(hubId: ((Response["data"] as! NSArray)[0] as! NSDictionary)["hub_id"] as! String)
                    self.selectedhubId.text = TestUtility().getSelectedHubId()
                    self.getDevicesList()
                }else{
                    self.selectedhubId.text = "No hub selected"
                     SystemAlert().removeLoader()
                }
            }else{
                SystemAlert().removeLoader()
            }
        }
    }
    func getDevicesList() {
        BlazeSdkClass.shared.getDevicesList(hubId:  TestUtility().getSelectedHubId()) { (Response) in
            SystemAlert().removeLoader()
            if((Response["status"] as! Bool) == true){
                if(Response["devices"] as! NSArray).count > 0{
                    self.addedList = (Response["devices"] as! NSArray) as! [NSDictionary]
                    self.deviceListTableVw.reloadData()
                    
                }
            }
        }
    }

    @IBAction func clickOnSettingsBtn(_ sender: Any) {
        if(TestUtility().getSelectedHubId() != ""){
            self.pushToController(with: .settingsVC, inStoryboard: .main)
        }else{
            // no hubs selected or added
        }
        
    }
    
    @IBAction func clickOnAddDeviceBtn(_ sender: Any) {
        self.pushToController(with: .deviceListVC, inStoryboard: .main)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.textLabel?.text = "Device name : \(addedList[indexPath.row]["device_name"] as! String)"

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC =  self.getViewController(with: .deviceInternalVC, inStoryboard: .main) as! DeviceInternalVC
        nextVC.deviceObject = addedList[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
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

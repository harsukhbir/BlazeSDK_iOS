//
//  HubListVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class HubListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var hubListTableView: UITableView!
    var hubList : [NSDictionary] = []
    let cellReuseIdentifier = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHubDetails()
        hubListTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

    }
    
    func getHubDetails() {
        SystemAlert().showLoader()
        BlazeSdkClass.shared.getHubDetails { (Response) in
            debugPrint(Response)
            if((Response["status"] as! Bool) == true){
                self.hubList = (Response["data"] as! NSArray) as! [NSDictionary]
                self.hubListTableView.reloadData()
               SystemAlert().removeLoader()
            }else{
                SystemAlert().removeLoader()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hubList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.textLabel?.text = "Hub name : \(hubList[indexPath.row]["hub_name"] as! String)"
        cell.detailTextLabel?.text = "Hub id : \(hubList[indexPath.row]["hub_id"] as! String)"

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TestUtility().setSelectedHubId(hubId: ((hubList[indexPath.row])["hub_id"] as! String))
        self.navigationController?.popViewController(animated: true)
       
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

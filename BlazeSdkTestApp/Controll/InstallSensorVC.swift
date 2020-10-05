//
//  InstallSensorVC.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 05/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

class InstallSensorVC: UIViewController,UITableViewDelegate, UITableViewDataSource,BlazeResponseManagerDelegate {
    func readResponse(response: NSDictionary) {
       // <#code#>
    }
    

    @IBOutlet weak var tblVw_Sensor: UITableView!
    var motionSensorArray = ["Bathroom 1","Bathroom 2","Hallway","Living / Common Space"]
    var doorSensorArray = ["Refrigerator","Front Door","Back / Garage Space"]
    var tempSensorArray = ["Bathroom 1"]
    var otherSensorArray = ["Siren"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func acn_BackBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 5
   }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        returnedView.backgroundColor = UIColor.clear

        let label = UILabel(frame: CGRect(x: 10, y: 2, width: tableView.bounds.size.width, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        if(section == 0){
        label.text = "Motion Sensors"
        }
        else if(section == 1){
            label.text = "Door Sensors"
        }
        else if(section == 2){
            label.text = "Temp/Humidity Sensor"
        }
        else if(section == 3){
            label.text = "Other"
        }
        else{
            let strA = self.attributedString(str: "Gateway Status: ONLINE")
            label.attributedText = strA
            
        }
        returnedView.addSubview(label)

        return returnedView
     
     
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if(section == 0){
               return 4
           }
           else if(section == 1){
               return 3
           }
           else if(section == 2){
               return 1
           }
           else if(section == 3){
               return 1
           }
           else{
               return 0
           }
      }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          let cellReuseIdentifier = "cell"
          let cell = tblVw_Sensor.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SensorCell
            if(indexPath.section == 0){
                cell.lbl_Title.text = motionSensorArray[indexPath.row]
                 
                let strStatus = self.attributedString(str: "Paired")
                cell.lbl_Status.attributedText = strStatus
                if(indexPath.row == motionSensorArray.count-1){
                   cell.lbl_Status.isHidden = true
                }
            }
            else if(indexPath.section == 1)
            {
            cell.lbl_Title.text = doorSensorArray[indexPath.row]
                cell.lbl_Status.isHidden = true
            }
            else if(indexPath.section == 2){
              cell.lbl_Title.text = tempSensorArray[indexPath.row]
                cell.lbl_Status.isHidden = true
            }
            else if(indexPath.section == 3){
              cell.lbl_Title.text = otherSensorArray[indexPath.row]
                 cell.lbl_Status.isHidden = true
            }
            
           return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    

}

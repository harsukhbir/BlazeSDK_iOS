//
//  HubScannedListVC.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 14/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import CoreBluetooth

class HubScannedListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,CBPeripheralDelegate, CBCentralManagerDelegate {
    
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    @IBOutlet weak var scannedTableView: UITableView!
    
    var hubList : [String] = []
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        scannedTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        SystemAlert().showLoader()
        // Do any additional setup after loading the view.
    }
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            TestUtility().clearAllDetails()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hubList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        cell.textLabel?.text = hubList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHubId = hubList[indexPath.row].between("(", ")")
        if selectedHubId?.count == 12 {
            TestUtility().setAddingHubId(hubId: selectedHubId!)
            self.pushToController(with: .hubAdditionVCStep1, inStoryboard: .main)
        }
        
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let pheripheralName = peripheral.name ?? ""
        
        
        if (pheripheralName.contains("Home-Ultimate(")) {
            if(!hubList.contains(pheripheralName)){
                hubList.append(pheripheralName)
            }
        }
        // Copy the peripheral instance
        self.peripheral = peripheral
        self.peripheral.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.centralManager.stopScan()
            self.scannedTableView.reloadData()
            SystemAlert().removeLoader()
        }
        
    }
    
    @IBAction func clickOnRescanButton(_ sender: Any) {
        SystemAlert().showLoader()
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
    }
    //right is the first encountered string after left
   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

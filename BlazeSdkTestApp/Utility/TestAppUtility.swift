//
//  TestAppUtility.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 10/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import Foundation

class TestUtility {
    
    func saveLoginDetails(req : NSDictionary)  {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: req)
        userDefaults.set(encodedData, forKey: "login_details")
        userDefaults.synchronize()
    }
    
    func extractLoginDetails() -> NSDictionary  {
        let loginDictDefaultsData  = UserDefaults.standard.data(forKey: "login_details")
        if(loginDictDefaultsData == nil){
            return NSDictionary()
        }
        let loginDict = NSKeyedUnarchiver.unarchiveObject(with: loginDictDefaultsData!) as! NSDictionary
        return loginDict

    }
    
    func saveTokenDetails(req : NSDictionary)  {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: req)
        userDefaults.set(encodedData, forKey: "token_details")
        userDefaults.synchronize()
    }
    
    func extractTokenDetails() -> NSDictionary  {
        let tokenDictDefaultsData  = UserDefaults.standard.data(forKey: "token_details")
        if(tokenDictDefaultsData == nil){
            return NSDictionary()
        }
        let tokenDict = NSKeyedUnarchiver.unarchiveObject(with: tokenDictDefaultsData!) as! NSDictionary
        return tokenDict

    }
    
    func saveHubDetails(req : NSDictionary) {
        let hubDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: req)
        hubDefaults.set(encodedData, forKey: "hub_details")
        hubDefaults.synchronize()
        
    }
    func extractHubDetails() -> NSDictionary  {
        let hubDictDefaultsData  = UserDefaults.standard.data(forKey: "hub_details")
        if(hubDictDefaultsData == nil){
            return NSDictionary()
        }
        let hubDict = NSKeyedUnarchiver.unarchiveObject(with: hubDictDefaultsData!) as! NSDictionary
        return hubDict

    }
    
    func clearAllDetails() {
        UserDefaults.standard.removeObject(forKey: "login_details")
        UserDefaults.standard.removeObject(forKey: "token_details")
        UserDefaults.standard.removeObject(forKey: "hub_details")
        UserDefaults.standard.removeObject(forKey: "selected_hub_id")
        UserDefaults.standard.removeObject(forKey: "enable_ble_list")
        UserDefaults.standard.synchronize()
    }
    
    func setSelectedHubId(hubId : String) {
        UserDefaults.standard.set(hubId, forKey: "selected_hub_id")
        UserDefaults.standard.synchronize()
    }
    func getSelectedHubId() -> String {
        if UserDefaults.standard.object(forKey: "selected_hub_id") == nil {
            return ""
        }else{
            return UserDefaults.standard.object(forKey: "selected_hub_id") as! String
        }
        
    }
    
    func setAddingHubId(hubId : String) {
        UserDefaults.standard.set(hubId, forKey: "add_hub_id")
        UserDefaults.standard.synchronize()
    }
    func getAddingHubId() -> String {
        if UserDefaults.standard.object(forKey: "add_hub_id") == nil {
            return ""
        }else{
            return UserDefaults.standard.object(forKey: "add_hub_id") as! String
        }
        
    }
    
    func enableBleList(status : Bool){
       UserDefaults.standard.set(status, forKey: "enable_ble_list")
       UserDefaults.standard.synchronize()
    }
    func isEnableBleList() -> Bool{
        if UserDefaults.standard.object(forKey: "enable_ble_list") == nil {
            return false
        }else{
            return (UserDefaults.standard.object(forKey: "enable_ble_list") as! Bool)
        }
    }
    
    
    
}
public extension String {

    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            , leftRange.upperBound <= rightRange.lowerBound
            else { return nil }

        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }

    var length: Int {
        get {
            return self.count
        }
    }

    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }

    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }

    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }

    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }

    func lastIndexOfCharacter(_ c: Character) -> Int? {
        guard let index = range(of: String(c), options: .backwards)?.lowerBound else
        { return nil }
        return distance(from: startIndex, to: index)
    }
}

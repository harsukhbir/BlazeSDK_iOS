//
//  RequestClass.swift
//  BlazeSdk
//
//  Created by Ram on 01/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import Foundation

@objc public protocol BlazeResponseManagerDelegate {
    func readResponse(response : NSDictionary)
}


public class BlazeSdkClass :NSObject, MqttResponseManagerDelegate  {
       
   public override init() {
        super.init()
    }
    public static let shared = BlazeSdkClass()

    /// use this delegate where ever required live response
    
    public var delegate: BlazeResponseManagerDelegate? = nil{
        didSet{
            MClass.shared.delegate = self
            MClass.shared.subscribeToResponse()
        }
    }
    
    /*************************************************** API methods *******************************************************************/
    
    /* Register user*/
    
    /// use this method is used to register user
    /// - Parameters:
    ///   - firstName:  user first name
    ///   - lastName : user last name
    ///   - emailId:  user email id
    ///   - password : user password
    
    public func registerUser(firstName: String, lastName : String, emailId : String, password : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().registerUserWith(firstName: firstName, lastName: lastName, emailId: emailId, password: password) { (response) in
           completion(response)
        }
    }
    
    /* verify regestering user*/
    /// use this method is used to verify user
    /// - Parameters:
    ///   - emailId:  user email id
    ///   - code : recived in register user function
    ///   - otp:  recived to email address
    
    public func verifyRegisteredUser(emailId : String,code : String, otp : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().verifyUserWith(emailId: emailId, code: code, otp: otp) { (response) in
             completion(response)
        }
    }
    
    
    /* Login User*/
    /// use this method is used to login existing user
    /// - Parameters:
    ///   - emailId:  user email id
    ///   - password : user password
    
    public func loginUser(emailId : String, password : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().userLoginWith(emailId: emailId, password: password) { (response) in
             completion(response)
        }
    }
    
    /* Get Tokens*/
    
    /// use this method is used to get access and refresh token. This tokens need to set SDK
    /// - Parameters:
    ///   - userId:  recived when login user/resgister user
    ///   - code : recived when login user/resgister user
    
    public func getAccessToken(userId : String, code : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().getAccessToken(userId: userId, code: code) { (response) in
            completion(response)
        }
    }
    
    /* Get code when access token expired*/
    /// use this method is used to get code
    /// - Parameters:
    ///   - userId:  user unique id
    ///   - refreshToken : refresh token
    
    public func getCodeUsingRefreshToken(userId : String, refreshToken : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().getCodeUsingRefreshToken(userId: userId, refreshToken: refreshToken) { (response) in
            completion(response)
        }
    }
    
    
    /* Get User Details*/
    /// use this method is used to get   user details.
    
    public func getUserDetails(completion : @escaping (NSDictionary) ->()){
        serverApiClass().getUserDetails() { (response) in
             completion(response)
        }
    }
    /* Update User Details*/
    
    /// use this method is used to update  user first name/ user last name
    /// - Parameters:
    ///   - firstName:  user first name
    ///   - lastName :  user last name
    
    public func updateUserDetails(firstName : String?, lastName : String?,completion : @escaping (NSDictionary) ->()){
       
        serverApiClass().updateUserDetails(firsName: firstName ?? "", lastName: lastName ?? "") { (response) in
             completion(response)
        }
        
    }
    
    /* Change User password */
    /// use this method is used to change current password
    /// - Parameters:
    ///   - password:  current password
    ///   - newPassword :  new password
    
    public func changePasword(password : String, newPassword : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().changePassword(password: password, newPassword: newPassword) { (response) in
             completion(response)
        }
    }
    
    /* get otp to forgot password */
    /// use this method is used to get otp when forgor password
    /// - Parameters:
    ///   - emailId:  user email id
    
    public func getOtpToForgotPassword(emailId : String ,completion : @escaping (NSDictionary) ->()){
        
        serverApiClass().getOtpToForgotPassword(emailId : emailId) { (response) in
             completion(response)
        }
        
    }
     /* Create new password with otp */
    /// use this method is used to create password with otp when forgor password
    /// - Parameters:
    ///   - otp:  recived to given mail
    ///   - code :  recived in 'getOtpToForgotPassword' function
    ///   - password : your new password
    
    public func createNewPasswordWithOtp(otp : String, code : String, password : String, completion : @escaping (NSDictionary) ->()){
        serverApiClass().createPasswordUsingOtp(otp: otp, code: code, password: password) { (response) in
             completion(response)
        }
    }
    
    
    /*************************************************** Add hub Methods *******************************************************************/
    /* Select hub in wifi list and connect to hub */
    
    /// use this method is used to connect hub when hub connected in background
    /// - Parameters:
    ///   - hubId:  backgound connected hub id
   
    public func connectHub(hubId : String , completion : @escaping(NSDictionary)->()){
        TClass().connectHub(hubId: hubId, completion: { (response) in
            completion(response)
        })
    }
    
    /* Send wifi credentials to hub */
    
    /// use this method is used to set wifi details to hub when hub connected in background
    /// - Parameters:
    ///   - ssid:  Wi-Fi name
    ///   - password:  Wi-Fi password
    ///   - hubId:  backgound connected hub id
    
    public func sendWifiCredentials(ssid : String, password : String, hubId : String, completion : @escaping(NSDictionary)->()){
        TClass().sendWifiCredentials(hubId : hubId, ssid : ssid, password : password){ (response) in
            completion(response)
        }
    }
    
     /* Check is hub connected in background or not while adding hub */
    
    /// - Parameters:
    ///   - hubId:  backgound connected hub id
    
    public func isConnectHub(hubId : String , completion : @escaping(Bool)->()){
        TClass().isConnectHub(hubId: hubId) { (response) in
            completion(response)
        }
    }
    
    /*************************************************** Online check Methods *******************************************************************/
    
    /* set hub id to sdk */
    
    /// use this method is used to set Hub id to SDK for  live events  of this hub
    /// - Parameters:
    ///   - hubId:  added hub id
    
    public func setHub(hubId : String,completion : @escaping(Bool)->()){
        MClass.shared.connectHubId(hubId: hubId) { (status) in
            completion(status)
        }
        
    }
    
     /* Check hub is online or not */
    
    /// use this method is used to check hub is online or not
    /// - Parameters:
    ///   - hubId:  added hub id
    
    public func checkHubStatus(hubId : String,completion : @escaping(Bool)->()){
        MClass.shared.checkHubIsOnlineOrNot(hubId: hubId) { (status) in
            completion(status)
        }
        
    }
     /* Add hub to cloud */
    
    /// use this method is used to add hub to cloud
    /// - Parameters:
    ///   - hubId:  added hub id
    ///   - hubName:  given hub name
    
    public func addHub(hubId : String, hubName : String, completion : @escaping(NSDictionary)->()){
        
        serverApiClass().addHub(hubId: hubId, hubName: hubName) { (response) in
             completion(response)
        }

    }
    /* Get all added hub details */
    /// use this method is used to  get all added hub details

    public func getHubDetails(completion : @escaping(NSDictionary)->()){
        
        serverApiClass().getHubDetails { (response) in
            completion(response)
        }

    }
    
    /* Get otp to delete hub */
    /// use this method is used to get otp to delete selected hub
    /// - Parameters:
    ///   - hubId:  added hub id
    
    public func getOtpToDeleteHub(hubId : String,completion : @escaping(NSDictionary)->()){
        
        serverApiClass().getOtpToDeleteHub(hubId: hubId) { (response) in
            completion(response)
        }
    }
    
    /* Delete hub with otp and code */
    /// Use this method is used to delete hub and make sure hub is in online state
    
    /// - Parameters:
    ///   - hubId:  added hub id
    ///   - otp:    recived in user regestred email
    ///   - code:  recived in 'getOtpToDeleteHub' function
    
    public func deleteHub(hubId : String,otp : String,code : String,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.deleteHub(hubId: hubId, otp: otp, code: code) { (response) in
            completion(response)
        }

    }
    
    /* force delete hub with otp and code */
    /// this method is used to delete permanently, when hub is offline and its not respond
    
    /// - Parameters:
    ///   - hubId:  added hub id
    ///   - otp:    recived in user regestred email
    ///   - code:  recived in 'getOtpToDeleteHub' function
    
    public func forceDeleteHub(hubId : String,otp : String,code : String,completion : @escaping(NSDictionary)->()){
        
        serverApiClass().deleteHub(hubId: hubId, otp: otp, code: code) { (response) in
            completion(response)
        }

    }
    
    /* get devices list */
    /// this method is used to get all added devices for perticular hub
    
    /// - Parameters:
    ///   - hubId:  added hub id
    
    public func getDevicesList(hubId :String ,completion : @escaping(NSDictionary)->()){
        
        serverApiClass().getDeviceList(hubId: hubId) { (response) in
            completion(response)
        }

    }
   
    /* pair device */
    /// this method is used to  pair device to hub
    /// - Parameters:
    ///   - catType:  category type for adding device.
    ///   - deviceType : device protocal type. ex : ZIGBEE / ZWAVE / BLE / WIFI
    
    public func pairDevice(hubId :String, catType : String,deviceType : String ,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.pairDevice(hubId: hubId, catType: catType, deviceType: deviceType) { (response) in
            completion(response)
        }

    }
    
    /* add device */
    /// this method is used to add device
    /// - Parameters:
    ///   - catType:  category type for adding device.
    ///   - deviceType : device protocal type. ex : ZIGBEE / ZWAVE / BLE / WIFI
    ///   - nodeId:  node Id recives when  device pair.
      /// - b_OneId : B.One Id recives when device pair
    
    public func addDevice(hubId :String,catType : String,deviceType : String,deviceName : String, nodeId : String,b_OneId : String ,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.addDevice(hubId: hubId, deviceName: deviceName, nodeId: nodeId, catType: catType, bOneId: b_OneId, deviceType: deviceType) { (response) in
            completion(response)
        }

    }
    
    /* update device */
    /// this method is used to update device
    /// - Parameters:
    /// - deviceName : name of the device
    /// - b_OneId : B.One Id for the device
    
    public func updateDevice(hubId :String,b_OneId : String,deviceName : String,completion : @escaping(NSDictionary)->()){
        
        serverApiClass().updateDevice(hubId: hubId, bOneId: b_OneId, deviceName: deviceName) { (response) in
            completion(response)
        }
    }
    
    /* delete device */
    /// this method is used to delete device
    /// - Parameters:
    /// - deviceType : device protocal type. ex : ZIGBEE / ZWAVE / BLE / WIFI
    /// - b_OneId : B.One Id for the device
    
    public func deleteDevice(hubId :String,b_OneId : String,deviceType :String,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.deleteDevice(hubId: hubId, bOneId: b_OneId, deviceType: deviceType) { (response) in
            completion(response)
        }

    }
    
    /* force delete device */
       /// this method is used to  force delete device
       /// - Parameters:
       /// - b_OneId : B.One Id for the device
       
    public func forceDeleteDevice(hubId :String,b_OneId : String,completion : @escaping(NSDictionary)->()){
        serverApiClass().deleteDevice(hubId: hubId, bOneId: b_OneId) { (response) in
             completion(response)
        }
    }
    
    /* delete all devices */
    /// this method is used to delete all devices
    /// - Parameters:
    /// - deviceType : device protocal type. ex : ZIGBEE / ZWAVE / BLE / WIFI
    
    public func deleteAllDevices(hubId :String,deviceType :String,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.deleteAllDevices(hubId: hubId, deviceType: deviceType) { (response) in
            completion(response)
        }

    }
    
    /* force delete all devices */
       /// this method is used for force delete all devices
       /// - Parameters:
       /// - deviceType : device protocal type. ex : ZIGBEE / ZWAVE / BLE / WIFI

       
    public func forceDeleteAllDevices(hubId :String,deviceType : String,completion : @escaping(NSDictionary)->()){
        serverApiClass().deleteAllDevices(hubId: hubId, deviceType: deviceType) { (response) in
             completion(response)
        }
    }
    
    /* device current device */
    /// this method is used to get current status of device
    /// - Parameters:
    /// - b_OneId : B.One Id for the device
    
    public func getDeviceCurrentStatus(hubId :String,b_OneId : String,completion : @escaping(NSDictionary)->()){
        serverApiClass().getCurrentDeviceStatus(hubId: hubId, bOneId: b_OneId) { (response) in
            completion(response)
        }
    }
    
    /* Wifi list */
    /// use this method to get wifi list
    /// - Parameters:
    /// - type : use 0 or 1 (use 0 when hub is offline and  connected in background wifi settings . use 1 when hub is in online)
   
    
    public func getWifiList(hubId :String,type : String,completion : @escaping(NSDictionary)->()){
        
        TClass().getWifiList(hubId: hubId, type: type) { (response) in
            completion(response)
        }
    }
    
    /* Change hub access point */
    /// use this method to change access point in offline mode or Online mode
    /// - Parameters:
    /// - type : use 0 or 1 (use 0 when hub is offline and  connected in background wifi settings . use 1 when hub is in online)
    /// - ssid : Wi-Fi name
    /// - password : Wi-Fi password
    
    public func changeHubAccessPoint(hubID : String,type : String,ssid : String , password : String,completion : @escaping(NSDictionary)->()){
        MClass.shared.changeHubAccesspoint(hubId: hubID, type: type, ssid: ssid, password: password) { (response) in
            completion(response)
        }
            
    }

    
    /// use this method to enable ble devices
    /// - Parameters:
    /// - type : use 0 or 1 (use 0 when hub is offline and  connected in background wifi settings . use 1 when hub is in online)
    /// - ssid : Wi-Fi name
    /// - password : Wi-Fi password
    
    public func enableBleDeviceList(hubID : String,status : Bool,time : Int?,completion : @escaping(NSDictionary)->()){
        
        MClass.shared.enableBleList(hubId: hubID, status: status, time: time) { (response) in
            completion(response)
        }
    
    }
    
    
     /* Read live response form hubs */
    func readLiveResponse(response: NSDictionary) {
        if(delegate != nil){
            delegate?.readResponse(response: response)
        }
        
    }
   
}

//
//  Webservices.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 12/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON


//class Webservices: NSObject {
//
//}
typealias ServerFailureCallBack=(_ error:Error?)->Void
typealias ServerProgressCallBack = (_ progress:Double?) -> Void
typealias ServerNetworkConnectionCallBck = (_ reachable:Bool) -> Void
typealias SuccessHandler = (_ obj: String) -> Void


final class Webservices
{
    static let instance = Webservices()
    var completion : SuccessHandler!

    private init() {}
    

    
    func postMethod(_ urlString:String,param: [String:Any], completion: @escaping (_ isSuccess :Bool, _ response: AnyObject) -> Void) {
        
       // if self.isReachable {
            
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJYelM3Y0tka1VXRm9mWVZUR2pYM0ZIbVVNSVQ1cnpGd2k2TW5LQktmYnI0In0.eyJleHAiOjE2MDI3Njg3NTMsImlhdCI6MTYwMjc2Njk1MywiYXV0aF90aW1lIjoxNjAyNzYwOTI4LCJqdGkiOiJiZGViYTEwMy04YTcxLTQxZmMtOGQ5NS04NDhmNzZmNTZjNGQiLCJpc3MiOiJodHRwczovL2F1dGguZGV2LmRhdGFkcml2ZW5jYXJlLm5ldC9hdXRoL3JlYWxtcy9kZGMiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiYzVjMDhhOWEtNTBhYy00NGMyLTk5YTYtMmE4OWU0MjkzODE4IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiZGRjLXdlYiIsIm5vbmNlIjoiYTA0YWIyYTEtNzI3MS00YjhjLTkyMzYtMTZjZTEwNWRmMzFkIiwic2Vzc2lvbl9zdGF0ZSI6ImMzZjRjZThmLTY4ZGQtNGU0YS1hZWYxLTk2NGE5ZmVlMDRmNyIsImFjciI6IjAiLCJhbGxvd2VkLW9yaWdpbnMiOlsiaHR0cHM6Ly9hZG1pbi5kZXYuZGF0YWRyaXZlbmNhcmUubmV0IiwiaHR0cHM6Ly9kZXYuZGF0YWRyaXZlbmNhcmUubmV0IiwiaHR0cDovL2xvY2FsaG9zdDozMDAxIiwiaHR0cDovL2xvY2FsaG9zdDozMDAwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwic3VwZXJBZG1pbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicHJlZmVycmVkX3VzZXJuYW1lIjoia2FyZWVtIn0.lWW9K1IuwuJBSHpRmipHdIb_RiPRr_El2hVvimVq9SMff5ppJUdCZux5A_fFFcZHUD8z1cCPR3W4heJWfXYQzPlcT5j7t_YdtprFkwIju1TfHGQ0NGGtAVDvrmuMSyIqvaaff9bfUPryViaowNIl_Vq5XtV0qTtuZZQ-DdNQLj7-8jW2h9dLiTZtzoDNzjbg0o1LqK2HsCKqtZ8s1pq2130vPO19qZxlMqKDRwYIsraTizMs8sVZpGRIW97mWneHX6c-8jP-VHkgHHcS9VDGUkZBaNN78UyzSo56xPaQ9MfjtsdR-uUsUriSxa86U2PnuhGwJtsxJ0zO0fRZp9O4eA", forHTTPHeaderField: "authorization")
        
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                    
                    _ = JSONDecoder()
                    // let value  = try! decoder.decode(login.self, from: data)
                    
                    //  print(value)
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    // response.
                    print("Api Response=>\(response as Any)")
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                       
                        completion(true,response as AnyObject)
                    } else {
                        
                        completion(false,response as AnyObject)
                    }
                } else {
                    DispatchQueue.main.async {
                        // Utility.showErrorAlert(error: .networkError)
                    }
                }
                }.resume()
      
    }
    
     // MARK: - URLSession methods
       func getwithoutHeaderMethod<T: Codable>(_ url:String, completion: @escaping (T?, _ error:String?) -> ()) {
           print(url)
           if(Reachability.isConnectedToNetwork()){
               var request = URLRequest(url: URL(string: url)!)
               request.httpMethod = "GET"
               request.timeoutInterval = 240
               request.cachePolicy = .reloadIgnoringLocalCacheData
               
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.setValue("application/json", forHTTPHeaderField: "Accept")
               // Create url session
               let session = URLSession(configuration: URLSessionConfiguration.default)
               // Call session data task.
               session.dataTask(with: request) { (data, response, error) -> Void in
                   // Check Data
                   DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                       SystemAlert().removeLoader()
                   }
                   if let data = data {
                       // Json Response
                       let re = try? JSONSerialization.jsonObject(with: data, options: [])
                       print(re as Any)
                       // response.
                       if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                           do {
                               let model = try JSONDecoder().decode(T.self, from: data)
                               completion(model,nil)
                           } catch let jsonErr {
                               print("failed to decode, \(jsonErr)")
                               completion(nil,error?.localizedDescription)
                           }
                           
                       } else {
                           completion(nil,error?.localizedDescription)
                       }
                   } else {
                       completion(nil,error?.localizedDescription)
                   }
               }.resume()
           } else {
               DispatchQueue.main.async {
                   SystemAlert().removeLoader()
                   completion(nil,"Please check your internet connection!")
               }
           }
       }
    func getMethod<T: Codable>(_ url:String, completion: @escaping (T?, _ error:String?) -> ()) {
        print(url)
        if(Reachability.isConnectedToNetwork()){
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.timeoutInterval = 240
            request.cachePolicy = .reloadIgnoringLocalCacheData
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
            request.setValue("token \(auth_token)", forHTTPHeaderField: "Authorization")
            // Create url session
            let session = URLSession(configuration: URLSessionConfiguration.default)
            // Call session data task.
            session.dataTask(with: request) { (data, response, error) -> Void in
                // Check Data
                DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                    SystemAlert().removeLoader()
                }
                if let data = data {
                    // Json Response
                    let re = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(re as Any)
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            completion(model,nil)
                        } catch let jsonErr {
                            print("failed to decode, \(jsonErr)")
                            completion(nil,error?.localizedDescription)
                        }
                        
                    } else {
                        completion(nil,error?.localizedDescription)
                    }
                } else {
                    completion(nil,error?.localizedDescription)
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                SystemAlert().removeLoader()
                completion(nil,"Please check your internet connection!")
            }
        }
    }
    
    
    
    func getMethodwithParam<T: Codable>(_ url:String, completion: @escaping (T?, _ error:String?) -> ()) {
           print(url)
           if(Reachability.isConnectedToNetwork()){
               var request = URLRequest(url: URL(string: url)!)
               request.httpMethod = "GET"
               request.timeoutInterval = 240
               request.cachePolicy = .reloadIgnoringLocalCacheData
               
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.setValue("application/json", forHTTPHeaderField: "Accept")
               let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
               request.setValue("token \(auth_token)", forHTTPHeaderField: "Authorization")
               // Create url session
               let session = URLSession(configuration: URLSessionConfiguration.default)
               // Call session data task.
               session.dataTask(with: request) { (data, response, error) -> Void in
                   // Check Data
                   DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                       SystemAlert().removeLoader()
                   }
                   if let data = data {
                       // Json Response
                       let re = try? JSONSerialization.jsonObject(with: data, options: [])
                       print(re as Any)
                       // response.
                       if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                           do {
                               let model = try JSONDecoder().decode(T.self, from: data)
                               completion(model,nil)
                           } catch let jsonErr {
                               print("failed to decode, \(jsonErr)")
                               completion(nil,error?.localizedDescription)
                           }
                           
                       } else {
                           completion(nil,error?.localizedDescription)
                       }
                   } else {
                       completion(nil,error?.localizedDescription)
                   }
               }.resume()
           } else {
               DispatchQueue.main.async {
                   SystemAlert().removeLoader()
                   completion(nil,"Please check your internet connection!")
               }
           }
       }
    
    
    func postMethod(_ urlString:String ,param: [String:Any], header: Bool, completion: @escaping (_ Error :String?, _ response: [String:Any]) -> Void) {
        print("PARAM==> \(param)")
        if(Reachability.isConnectedToNetwork()){
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")

             let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
            request.setValue("token \(auth_token)", forHTTPHeaderField: "Authorization")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                   let  dfd = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(dfd as Any)
                    DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                         SystemAlert().removeLoader()
                    }
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        do {
                           print(response)
                        } catch let jsonErr {
                            print("failed to decode, \(jsonErr)")
                           
                        }
                    }
                    else {
                        print("failed to decode, \(error?.localizedDescription ?? "")")
                       // completion(error?.localizedDescription)
                    }
                } else {
                    //completion(error?.localizedDescription)
                     print("failed to decode, \(error?.localizedDescription ?? "")")
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                 SystemAlert().removeLoader()
                //completion("Please check your internet connection!", nil)
                print("Please check your internet connection")
            }
        }
    }
    
    
    
    func postwithoutHeaderMethod<T: Codable>(_ urlString:String ,param: [String:Any], header: Bool, completion: @escaping (_ Error :String?, _ response: T?) -> Void) {
        print("PARAM==> \(param)")
        print(urlString)
        if(Reachability.isConnectedToNetwork()){
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")

           
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                   let  dfd = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(dfd as Any)
                    DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                      SystemAlert().removeLoader()
                    }
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,model)
                        } catch let jsonErr {
                            print("failed to decode, \(jsonErr)")
                            completion(jsonErr.localizedDescription,nil)
                        }
                    }
                    else {
                        completion(error?.localizedDescription,nil)
                    }
                } else {
                    completion(error?.localizedDescription, nil)
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                SystemAlert().removeLoader()
                completion("Please check your internet connection!", nil)
            }
        }
    }
    
    
    
    
    func putwithoutHeaderMethod<T: Codable>(_ urlString:String ,param: [String:Any], header: Bool, completion: @escaping (_ Error :String?, _ response: T?) -> Void) {
        print("PARAM==> \(param)")
        print(urlString)
        if(Reachability.isConnectedToNetwork()){
            guard let serviceUrl = URL(string: urlString) else { return }
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "PUT"
            request.timeoutInterval = 60
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")

           
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                return
            }
            request.httpBody = httpBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // Check Data
                if let data = data {
                    // Json Response
                   let  dfd = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(dfd as Any)
                    DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                         SystemAlert().removeLoader()
                    }
                    // response.
                    if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,model)
                        } catch let jsonErr {
                            print("failed to decode, \(jsonErr)")
                            completion(jsonErr.localizedDescription,nil)
                        }
                    }
                    else {
                        completion(error?.localizedDescription,nil)
                    }
                } else {
                    completion(error?.localizedDescription, nil)
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                SystemAlert().removeLoader()
                completion("Please check your internet connection!", nil)
            }
        }
    }
    
    func putMethod<T: Codable>(_ urlString:String ,param: [String:Any], header: Bool, completion: @escaping (_ Error :String?, _ response: T?) -> Void) {
           print("PARAM==> \(param)")
           if(Reachability.isConnectedToNetwork()){
               guard let serviceUrl = URL(string: urlString) else { return }
               var request = URLRequest(url: serviceUrl)
               request.httpMethod = "PUT"
               request.timeoutInterval = 60
               request.cachePolicy = .reloadIgnoringLocalCacheData
               request.setValue("application/json", forHTTPHeaderField: "Content-Type")
               request.setValue("application/json", forHTTPHeaderField: "accept")

               let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
               request.setValue("token \(auth_token)", forHTTPHeaderField: "Authorization")
               guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                   return
               }
               request.httpBody = httpBody
               let session = URLSession.shared
               session.dataTask(with: request) { (data, response, error) in
                   // Check Data
                   if let data = data {
                       // Json Response
                      let  dfd = try? JSONSerialization.jsonObject(with: data, options: [])
                       print(dfd as Any)
                       DispatchQueue.main.asyncAfter(deadline: .now() +  0.4) {
                           SystemAlert().removeLoader()
                       }
                       // response.
                       if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                           do {
                               let model = try JSONDecoder().decode(T.self, from: data)
                               completion(nil,model)
                           } catch let jsonErr {
                               print("failed to decode, \(jsonErr)")
                               completion(jsonErr.localizedDescription,nil)
                           }
                       }
                       else {
                           completion(error?.localizedDescription,nil)
                       }
                   } else {
                       completion(error?.localizedDescription, nil)
                   }
               }.resume()
           } else {
               DispatchQueue.main.async {
                    SystemAlert().removeLoader()
                   completion("Please check your internet connection!", nil)
               }
           }
       }
    
    
    func createProfileWithImage( profile:UIImage, param:[String:AnyObject], url:String , resultApi:@escaping( _ response: JSON?,_ error:Error?) -> Void) {
        
         if(Reachability.isConnectedToNetwork()){
            let profileData = profile.jpegData(compressionQuality: 0.5)!
                   let fullURL = url
                   let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
                   let header: HTTPHeaders = ["Authorization" : "token \(auth_token)"]
                   AF.upload(multipartFormData: { multipartFormData in
                       for (key, value) in param {
                           if let temp = value as? String {
                           multipartFormData.append(temp.data(using: .utf8)!, withName: key)}
                           multipartFormData.append(profileData, withName: "image",fileName: "image.jpg", mimeType: "image/jpg")
                       }
                   }, to: fullURL, method:.put, headers:header)
                       .responseJSON { response in
                           debugPrint(response)
                        SystemAlert().removeLoader()
                        let json = JSON(response.value ?? nil!)
                           print("Image JSON : \(response)")
                           resultApi(json, nil)
                   }
         }else{
           DispatchQueue.main.async {
                SystemAlert().removeLoader()
                resultApi("Please check your internet connection!", nil)
            }
        }
      
    }
    
    func uploadImage(_ url: String,
                           imageURL:URL,
                           imageName: String ,
                           token: String,
                           success:@escaping (JSON) -> Void,
                           fail:@escaping (_ status: Int, _ message: String) -> Void)
    {
        let fullURL = url
        let header: HTTPHeaders = ["barrier" : token]
        
        AF.upload(multipartFormData: { multipartFormData in
        multipartFormData.append(imageURL, withName: imageName)
        }, to: fullURL, method:.post, headers:header)
            .responseJSON { response in
                debugPrint(response)
            
               let json = JSON(response.value ?? nil)
                print("Image JSON : \(json)")
                success(json)
        }
    }
    func UploadDatawithMultipleImage( profile:UIImage, param:[String:AnyObject], url:String ,files : [UIImage], resultApi:@escaping( _ response: JSON?,_ error:Error?) -> Void) {
        
         if(Reachability.isConnectedToNetwork()){
            let profileData = profile.jpegData(compressionQuality: 0.5)!
                   let fullURL = url
                   let auth_token = UserDefaults.standard.value(forKey: "auth_token") as? String ?? ""
                   let header: HTTPHeaders = ["Authorization" : "token \(auth_token)"]
                   AF.upload(multipartFormData: { multipartFormData in
                       for (key, value) in param {
                           if let temp = value as? String {
                           multipartFormData.append(temp.data(using: .utf8)!, withName: key)}
                           multipartFormData.append(profileData, withName: "cover_image",fileName: "image.jpg", mimeType: "image/jpg")
                       }
                    
                    if files.count>0{
                        for i in 0..<files.count{
                            let imageData1 = files[i].jpegData(compressionQuality: 0.5)!
                            multipartFormData.append(imageData1, withName: "stickers", fileName: "image.jpg", mimeType: "image/jpeg")
                        }
                    }
                    
                   }, to: fullURL, method:.post, headers:header)
                       .responseJSON { response in
                           debugPrint(response)
                        SystemAlert().removeLoader()
                        let json = JSON(response.value ?? nil!)
                           print("Image JSON : \(response)")
                           resultApi(json, nil)
                   }
         }else{
           DispatchQueue.main.async {
                SystemAlert().removeLoader()
                resultApi("Please check your internet connection!", nil)
            }
        }
      
    }
   
}





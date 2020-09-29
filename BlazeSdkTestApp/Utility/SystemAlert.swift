//
//  AlertController+Extension.swift
//  WattsUp
//
//  Created by Gopi Krishna on 30/03/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

enum SystemAlertType : String {
    case doneAlert = "Done"
    case okAlert = "Ok"
    case cancelAlert = "Cancel"
    case closeAlert = "Close"
    case retryAlert = "Retry"
    case submitAlert = "Submit"
    case tryAgainAlert = "Try again"
    case wifiMode = "Wi-Fi Mode"
    case noAlert = "No"
    case yesAlert = "Yes"
    case logoutAlert = "Logout"
    case deleteAlert = "Delete"
    case resolveAlert = "Resolve"
    case refresh = "Refresh"
    case saveAlert = "Save"
    case removeAlert = "Remove"
    case ignoreAlert = "Ignore"
    case continueAlert = "Continue"
}

var vSpinner : UIView?
var vSpinnerForSetUp : UIView?
var alertController : UIAlertController?
public class SystemAlert {
    ///This Fuction doesnot throw any closure for execution
    ///
    ///This will accept title: String, Message: String, alert: SystemAlertType
    func basicNonActionAlert(withTitle title: String, message : String, alert:SystemAlertType){
        
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
            vSpinnerForSetUp?.removeFromSuperview()
            vSpinnerForSetUp = nil
            alertController?.dismiss(animated: true, completion: nil)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: alert.rawValue, style: .default) { action in
            }
            OKAction.setValue(UIColor.init(named: "PrimaryButtonBGColor"), forKey: "titleTextColor")
            alertController!.addAction(OKAction)
           
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                // topController should now be your topmost view controller
                topController.present(alertController!, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    func removeAlert(){
        alertController?.dismiss(animated: true, completion: nil)
    }
    
    ///This Fuction throw alert action of its button using  closure for execution
    ///
    ///This will accept title: String, Message: String, actions : [SystemAlertType], handler: escaping Closure
    func basicActionAlert(withTitle title: String, message : String, actions:[SystemAlertType],  handler: @escaping (SystemAlertType) -> ()){
        
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
            vSpinnerForSetUp?.removeFromSuperview()
            vSpinnerForSetUp = nil
            alertController?.dismiss(animated: true, completion: nil)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                let actionButton = UIAlertAction(title: action.rawValue, style: .default) { alertAction in
                    handler(action)
                }
                actionButton.setValue(UIColor.init(named: "PrimaryButtonBGColor"), forKey: "titleTextColor")
                alertController!.addAction(actionButton)
            }
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                // topController should now be your topmost view controller
                topController.present(alertController!, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func showLoader() {
        removeLoader()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let spinnerView = UIView.init(frame: topController.view.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
            //            spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.9)
            var widthSize : CGFloat = spinnerView.frame.size.width - 20
            debugPrint(UIScreen.main.bounds.size.width)
            debugPrint(UIScreen.main.bounds.size.height)
            if UIScreen.main.bounds.size.width == 375{//8
                widthSize = spinnerView.frame.size.width - 20
                if UIScreen.main.bounds.size.height == 812{//x
                    widthSize = spinnerView.frame.size.width + 6
                }
            }
            else if UIScreen.main.bounds.size.width == 326{//6,6s
                widthSize = spinnerView.frame.size.width - 70
            }
            else if UIScreen.main.bounds.size.width == 414{ //8plus
                widthSize = spinnerView.frame.size.width - 25
                if UIScreen.main.bounds.size.height == 896{ //xr
                    widthSize = spinnerView.frame.size.width + 6
                }
            }
            else if UIScreen.main.bounds.size.width == 768{
                widthSize = spinnerView.frame.size.width - 220
            }
            let activityIndicatorView =  NVActivityIndicatorView(frame: spinnerView.bounds, type: .ballSpinFadeLoader, color: UIColor.init(named: "PrimaryButtonBGColor"),padding:( widthSize) )
            
            //            let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
            //            ai.startAnimating()
            //            ai.center = spinnerView.center
            activityIndicatorView.startAnimating()
            
            DispatchQueue.main.async {
                spinnerView.addSubview(activityIndicatorView)
                vSpinner = spinnerView
                topController.view.addSubview(vSpinner!)
            }
        }
    }
    
    func showLoadersForSetUp() {
        removeLoaderForSetUp()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let spinnerView = UIView.init(frame: topController.view.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
            //            spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.9)
            var widthSize : CGFloat = spinnerView.frame.size.width - 20
            debugPrint(UIScreen.main.bounds.size.width)
            debugPrint(UIScreen.main.bounds.size.height)
            if UIScreen.main.bounds.size.width == 375{//8
                widthSize = spinnerView.frame.size.width - 20
                if UIScreen.main.bounds.size.height == 812{//x
                    widthSize = spinnerView.frame.size.width + 6
                }
            }
            else if UIScreen.main.bounds.size.width == 326{//6,6s
                widthSize = spinnerView.frame.size.width - 70
            }
            else if UIScreen.main.bounds.size.width == 414{ //8plus
                widthSize = spinnerView.frame.size.width - 25
                if UIScreen.main.bounds.size.height == 896{ //xr
                    widthSize = spinnerView.frame.size.width + 6
                }
            }
            else if UIScreen.main.bounds.size.width == 768{
                widthSize = spinnerView.frame.size.width - 220
            }
            let activityIndicatorView =  NVActivityIndicatorView(frame: spinnerView.bounds, type: .ballSpinFadeLoader, color: UIColor.init(named: "PrimaryButtonBGColor"),padding:( widthSize) )
            
            //            let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
            //            ai.startAnimating()
            //            ai.center = spinnerView.center
            activityIndicatorView.startAnimating()
            
            DispatchQueue.main.async {
                spinnerView.addSubview(activityIndicatorView)
                vSpinnerForSetUp = spinnerView
                topController.view.addSubview(vSpinnerForSetUp!)
            }
        }
    }
    
    func showLoaderonView(onView : UIView) {
        removeLoader()
        
        onView.frame.size.width = UIScreen.main.bounds.size.width
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.clear
        var widthSize : CGFloat = 0
        widthSize = spinnerView.frame.size.width / 2 - 20
        let activityIndicatorView =  NVActivityIndicatorView(frame: spinnerView.bounds, type: .ballSpinFadeLoader, color: UIColor.init(named: "PrimaryButtonBGColor"),padding:( widthSize) )
        activityIndicatorView.startAnimating()
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicatorView)
            vSpinner = spinnerView
            onView.addSubview(vSpinner!)
        }
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    func removeLoaderForSetUp() {
        DispatchQueue.main.async {
            vSpinnerForSetUp?.removeFromSuperview()
            vSpinnerForSetUp = nil
        }
    }
    func topMostController() -> UIViewController {
        var topController : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        while (topController.presentingViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

//
//  ViewController.swift
//  BioMatriCTouchDemo
//
//  Created by SOTSYS113 on 20/11/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var switchTouchID: UISwitch!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func TouchIdOnOff(_ sender: Any) {
        
        if (self.isTouchIdAvailable()){
            if switchTouchID.isOn {
                print("TouchID On")
                touchIdAuthentication()
            }
            else{
                print("TouchID Off")
            }
            UserDefaults.standard.set(switchTouchID.isOn, forKey: "TouchIdON")
        }else{
            switchTouchID.isOn = false
            print("TouchID Off")
        }
    }
    func isTouchIdAvailable() -> Bool {
        
        var isTouchIdOn : Bool =  true
        var policy: LAPolicy?
        let authenticationContext = LAContext()
        var error:NSError?
        
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            policy = .deviceOwnerAuthentication
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        guard authenticationContext.canEvaluatePolicy(policy!, error: &error)
            else{
               print("This device does not have a TouchID activate.")
                isTouchIdOn = false
                return isTouchIdOn
        }
        return isTouchIdOn
    }
    // MARK: - Touch Id method
    func touchIdAuthentication(){
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        //        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
        //
        //            AppUtility.showSimpleAlert(withMessage: "This device does not have a TouchID sensor.", yesCompletionHandler: { (_) in
        //            })
        //            return
        //        }
        var policy: LAPolicy?
        
        if #available(iOS 9.0, *) {
            // iOS 9+ users with Biometric and Passcode verification
            policy = .deviceOwnerAuthentication
        } else {
            // iOS 8+ users with Biometric and Custom (Fallback button) verification
            policy = .deviceOwnerAuthenticationWithBiometrics
        }
        guard authenticationContext.canEvaluatePolicy(policy!, error: &error)
            else{
                print("Touch ID Verify")
        
                return
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            policy!,
            localizedReason: "Not Available",
            reply: { [unowned self] (success, error) -> Void in
                
                if( success ) {
                    
                    // Fingerprint recognized
                    // Go to view controller
                  
                    
                }else {
                    
                    // Check if there is an error
                    if let error = error {
                        //                        let message = self.errorMessageForLAErrorCode(error.code)
                        print(error.localizedDescription)
                        //                        AppUtility.showSimpleAlert(withMessage: error.localizedDescription, yesCompletionHandler: { (_) in
                        
                        //                        })
                    }
                }
        })
    }
}


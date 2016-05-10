//
//  LoginViewController.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

	@IBOutlet weak var touchIDLogin: UIButton!
	@IBOutlet weak var loadingTouchId: UIActivityIndicatorView!
	let authenticationContext = LAContext()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		var error:NSError?
		
		// 2. Check if the device has a fingerprint sensor
		// If not, show the user an alert view and bail out!
		guard authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
			touchIDLogin.hidden = true
			return
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func checkTouchId(sender: UIButton) {
		loadingTouchId.startAnimating()
		touchIDLogin.hidden = true
		authenticationContext.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Just for the protein skills")
		{ (success, error) in
			if (success){
				self.loadingTouchId.stopAnimating()
				self.touchIDLogin.hidden = false
				self.performSegueWithIdentifier("goToConnect", sender: self)
			} else {
				self.loadingTouchId.stopAnimating()
				self.touchIDLogin.hidden = false
				if let error = error {
					let message = errorMessageForLAErrorCode(error.code)
					showAlertWithTitle("Touch ID", message: message, view: self)
				}
			}
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

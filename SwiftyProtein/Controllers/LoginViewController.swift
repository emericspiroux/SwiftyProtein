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
	@IBOutlet weak var touchIdLogo: UIImageView!
	@IBOutlet weak var errorLabel: UILabel!
	
	let authenticationContext = LAContext()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		var error:NSError?
		
		// 2. Check if the device has a fingerprint sensor
		// If not, show the user an alert view and bail out!
		guard authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
			touchIdPresentation(false)
			return
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func checkTouchId(sender: UIButton) {
		loadingState(true)
		authenticationContext.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Just for the protein skills")
		{ (success, error) in
			dispatch_async(dispatch_get_main_queue(), {
			if (success){
				self.loadingState(false)
				self.performSegueWithIdentifier("goToConnect", sender: self)
			} else {
				self.loadingState(false)
				if let error = error {
					let message = errorMessageForLAErrorCode(error.code)
					self.displayErrorLabel(message)
				}
			}
			})
		}
	}
	
	// MARK: - animation regulators
	
	func loadingState(status:Bool){
		if status{
			loadingTouchId.startAnimating()
			touchIDLogin.hidden = true
			errorLabel.hidden = true
		} else {
			loadingTouchId.stopAnimating()
			self.touchIdLogo.hidden = false
			self.touchIDLogin.hidden = false
			self.errorLabel.hidden = true
		}
	}
	
	func touchIdPresentation(status:Bool){
		if status{
			touchIdLogo.alpha = 1
			touchIDLogin.hidden = false
			errorLabel.hidden = true
		} else {
			touchIdLogo.alpha = 0.2
			touchIDLogin.hidden = true
			displayErrorLabel("Sorry but you don't have Touch Id Enabled on your phone...")
		}
	}
	
	func displayErrorLabel(message:String){
		errorLabel.hidden = false
		errorLabel.text = message
	}

}

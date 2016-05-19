//
//  LoginViewController.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import LocalAuthentication

/// LoginViewController controll the initial view in Login.storyboard
class LoginViewController: UIViewController {
	
	//MARK: - Proprieties
	/// Invisible touch ID button login
	@IBOutlet weak var touchIDLogin: UIButton!
	
	/// Activity indicator showed when touch id verify informations
	@IBOutlet weak var loadingTouchID: UIActivityIndicatorView!
	
	/// Image view of the touch Id logo
	@IBOutlet weak var touchIDLogo: UIImageView!
	
	/// Red label for displaying error on authentification
	@IBOutlet weak var errorLabel: UILabel!
	
	/// Touch ID authentification context
	let authenticationContext = LAContext()
	
	
	//MARK: - Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		detectTouchID()
    }
	
	//MARK: - Buttons
	/**
	What will be done when the user touch the `touchIDLogin` UIButton
	
	- Parameter sender: touch in UIButton source
	*/
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
	
	// MARK: - Animation regulators
	/**
	Start activity indicator `loadingTouchID`, hide `touchIDLogin` Button and `touchIDLogo` when true.
	`False` value will hide the `errorLabel`
	
	- Parameter status: True when loading something
	*/
	func loadingState(status:Bool){
		if status{
			loadingTouchID.startAnimating()
			touchIDLogin.hidden = true
			errorLabel.hidden = true
		} else {
			loadingTouchID.stopAnimating()
			self.touchIDLogo.hidden = false
			self.touchIDLogin.hidden = false
			self.errorLabel.hidden = true
		}
	}
	
	//MARK: - Private methods
	/**
	Hide `touchIDLogin` button, change alpha of `touchIDLogo` to 0.2 and display error label when it's false.
	false means that the touchID is not enabled.
	
	- Parameter status: True when touchID is enabled
	*/
	private func touchIdPresentation(status:Bool){
		if status{
			touchIDLogo.alpha = 1
			touchIDLogin.hidden = false
			errorLabel.hidden = true
		} else {
			touchIDLogo.alpha = 0.2
			touchIDLogin.hidden = true
			displayErrorLabel("Sorry but you don't have Touch Id Enabled on your phone...")
		}
	}
	
	/**
	Set the message and visible the `errorLabel`
	
	- Parameter message: message of the error.
	*/
	private func displayErrorLabel(message:String){
		errorLabel.hidden = false
		errorLabel.text = message
	}
	
	/**
	Check if the touchID is enabled with the LAContext
	*/
	private func detectTouchID(){
		var error:NSError?
		
		// Check if the device has a fingerprint sensor
		guard authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
			touchIdPresentation(false)
			return
		}
	}

}

//
//  LAErrorCodes.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import LocalAuthentication

func errorMessageForLAErrorCode( errorCode:Int ) -> String{
	
	var message = ""
	
	switch errorCode {
		
	case LAError.AppCancel.rawValue:
		message = "Authentication was cancelled by application"
		
	case LAError.AuthenticationFailed.rawValue:
		message = "The user failed to provide valid credentials"
		
	case LAError.InvalidContext.rawValue:
		message = "The context is invalid"
		
	case LAError.PasscodeNotSet.rawValue:
		message = "Passcode is not set on the device"
		
	case LAError.SystemCancel.rawValue:
		message = "Authentication was cancelled by the system"
		
	case LAError.TouchIDLockout.rawValue:
		message = "Too many failed attempts."
		
	case LAError.TouchIDNotAvailable.rawValue:
		message = "TouchID is not available on the device"
		
	case LAError.UserCancel.rawValue:
		message = "The user did cancel"
		
	case LAError.UserFallback.rawValue:
		message = "The user chose to use the fallback"
		
	default:
		message = "Did not find error code on LAError object"
		
	}
	
	return message
	
}
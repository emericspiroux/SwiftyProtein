//
//  ShowAlert.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

func showAlertWithTitle( title:String, message:String, view:UIViewController ) {
 
	let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
	
	let okAction = UIAlertAction(title: "J'ai compris !", style: .Default, handler: nil)
	alertVC.addAction(okAction)
	
	dispatch_async(dispatch_get_main_queue()) { () -> Void in
		
		view.presentViewController(alertVC, animated: true, completion: nil)
		
	}
	
}

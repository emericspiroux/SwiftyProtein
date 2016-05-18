//
//  ShowAlert.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

/**
Show a popup with a custom title, custom message and a button "I understand !".

	class MyViewController: UIViewController {
		func viewDidAppear(){
			self.superDidAppear()
			showAlertWithTitle("My title", message: "My Message", view: self)
		}
	}

- Parameters:
	- title: Title of the popup display.
	- message: Message of the popup display.
	- view: ViewController who displaying the popup


*/
func showAlertWithTitle( title:String, message:String, view:UIViewController ) {
	let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)

	let okAction = UIAlertAction(title: "I understand !", style: .Default, handler: nil)
	alertVC.addAction(okAction)
	
	dispatch_async(dispatch_get_main_queue()) { () -> Void in
		
		view.presentViewController(alertVC, animated: true, completion: nil)
		
	}
}


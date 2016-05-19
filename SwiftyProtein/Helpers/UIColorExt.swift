//
//  File.swift
//  SwiftyProtein
//
//  Created by larry on 11/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

/// Extension from UIColor
extension UIColor {
	/**
	Give an `UIColor` from an hexadecimal value format.
	
	```
	let myColor = UIColor.fromRGB(0xFFFFFF)
	```

	- Parameters:
		- rgbValue: Title of the popup display.
	
	- returns: `UIColor` from the hexadecimal value.
	*/
	static func fromRGB(rgbValue: UInt) -> UIColor {
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
}
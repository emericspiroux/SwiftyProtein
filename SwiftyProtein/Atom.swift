//
//  Atom.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Atom {
	var data:[String]
	
	init(lineFile:String){
		data = lineFile.componentsSeparatedByString(" ")
	}
}

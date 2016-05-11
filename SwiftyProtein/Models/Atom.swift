//
//  Atom.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Atom {
	
	//MARK: - Data table string
	var data:[String]
	
	//MARK: - Lazy var data must have data or allways fail
	lazy var count:Int = {
		return (self.data.count - 1)
	}()
	
	lazy var id:String = {
		return (self.data[1])
	}()
	
	lazy var details:String = {
		return (self.data[1])
	}()
	
	lazy var x:Float = {
		return (Float(self.data[6]))
	}()!
	
	lazy var y:Float = {
		return (Float(self.data[6]))
	}()!
	
	lazy var z:Float = {
		return (Float(self.data[6]))
	}()!
	
	lazy var type:String = {
		return (self.data[11])
	}()
	
	// MARK: - Constructor
	init(lineFile:String){
		data = lineFile.componentsSeparatedByString(" ")
	}
	
	
}

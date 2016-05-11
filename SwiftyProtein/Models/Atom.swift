//
//  Atom.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import UIKit

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
		return (Float(self.data[7]))
	}()!
	
	lazy var z:Float = {
		return (Float(self.data[8]))
	}()!
	
	lazy var type:String = {
		return (self.data[11])
	}()
	
	lazy var color:UIColor = {
		return (UIColor.getAtomColor(self.type))
	}()
	
	// MARK: - Constructor
	init?(lineFile:String){
		let dataFiltered = lineFile.componentsSeparatedByString(" ").filter{$0 != ""}
		guard (dataFiltered.count == 12 && dataFiltered[0] == "ATOM") else {
			return nil
		}
		data = dataFiltered
	}
	
	
}

private extension UIColor{
	static func getAtomColor(type:String) -> UIColor {
		switch type {
		case "H":
			return (UIColor.whiteColor())
		case "C":
			return (UIColor.blackColor())
		case "N":
			return (UIColor.blueColor())
		case "O":
			return (UIColor.redColor())
		case "F", "Cl", "CL":
			return (UIColor.greenColor())
		case "Br", "BR":
			return (UIColor.fromRGB(0x992200))
		case "I":
			return (UIColor.fromRGB(0x6600bb))
		case "He", "Ne", "Ar", "Xe", "Kr", "HE", "NE", "AR", "XE", "KR":
			return (UIColor.fromRGB(0x00ffff))
		case "P":
			return (UIColor.fromRGB(0xff9900))
		case "S":
			return (UIColor.fromRGB(0xdddd00))
		case "B":
			return (UIColor.fromRGB(0xffaa77))
		case "Li", "Na", "K", "Rb", "Cs", "Fr", "LI", "NA", "K", "RB", "CS", "FR":
			return (UIColor.fromRGB(0x7700ff))
		case "Be", "Mg", "Ca", "Sr", "Ba", "Ra", "BE", "MG", "CA", "SR", "BA", "RA":
			return (UIColor.fromRGB(0x007700))
		case "Ti", "TI":
			return (UIColor.fromRGB(0x999999))
		case "Fe", "FE":
			return (UIColor.fromRGB(0xdd7700))
		default:
			return (UIColor.fromRGB(0xdd77ff))
		}
	}
}


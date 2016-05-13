//
//  Atom.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import UIKit
import SceneKit

class Atom {
	
	//MARK: - Data table string
	var data:[String]
	
	//MARK: - Lazy var data must have data or allways fail
	lazy var count:Int = {
		return (self.data.count - 1)
	}()
	
	lazy var id:Int = {
		return (Int(self.data[1]))
	}()!
	
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
		return (getAtomColor(self.type))
	}()
	
	lazy var atomRadius:Int = {
		return (getAtomRadius(self.type))
	}()
	
	lazy var position:SCNVector3 = {
		return (SCNVector3(x:self.x,y:self.y,z:self.z))
	}()
	
	// MARK: - Constructor
	init?(lineFile:String){
		let dataFiltered = lineFile.componentsSeparatedByString(" ").filter{$0 != ""}
		guard (dataFiltered.count == 12 && dataFiltered[0] == "ATOM") else {
			return nil
		}
		data = dataFiltered
	}
	
	// MARK: - 3D Comparaison
	func distance(receiver:Atom) -> CGFloat{
		let xd = receiver.x - self.x
		let yd = receiver.y - self.y
		let zd = receiver.z - self.z
		let distance = CGFloat(sqrt(xd * xd + yd * yd + zd * zd))
		
		if (distance < 0){
			return (distance * -1)
		} else {
			return (distance)
		}
	}
	
	func middlePoint(receiver:Atom) -> SCNVector3 {
		return (SCNVector3(x: (receiver.x + self.x)/2, y: (receiver.y + self.y)/2, z: (receiver.z + self.z)/2))
	}
	
	func direction(receiver:Atom) -> SCNVector3{
		let xd = Double(receiver.x - self.x)
		let yd = Double(receiver.y - self.y)
		let zd = Double (receiver.z - self.z)

		return (SCNVector3(x: Float(xd), y: Float(yd) , z: Float(zd)))
	}
}

func getAtomColor(type:String) -> UIColor {
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

func getAtomRadius(type:String) -> Int{
	switch type {
	case "H":
		return (120)
	case "C":
		return (170)
	case "N":
		return (155)
	case "O":
		return (152)
	case "F":
		return (147)
	case "Cl", "CL":
		return (175)
	case "Br", "BR":
		return (185)
	case "I":
		return (198)
	case "He", "HE":
		return (140)
	case "Ne", "NE":
		return (154)
	case "Ar", "AR":
		return (188)
	case "Xe", "XE":
		return (216)
	case  "Kr", "KR":
		return (202)
	case "P":
		return (180)
	case "S":
		return (180)
	case "Li", "LI":
		return (182)
	case "Na", "NA":
		return (210)
	case "K", "K":
		return (275)
	case "Mg", "MG":
		return (173)
	default:
		return (100)
	}

}



//
//  Ligand.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SWXMLHash
import SceneKit

enum LigandError: ErrorType {
	case EmptyInfos
	case NoEndKeyword
}


class Ligand {
	
	// MARK: - Needle
	var name:String
	var atomList = [Atom]()
	var connectList = [Connect]()
	
	
	//MARK: - lazy infos
	
	lazy var type:String = {
		if let ligandType = self.infosXML!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["type"] {
			return (ligandType)
		}
		return ("No type")
	}()
	
	lazy var molecularWeight:String = {
		if let molecularWeight = self.infosXML!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["molecularWeight"] {
			return (molecularWeight)
		}
		return ("No molecular weight")
	}()
	
	lazy var chemicalName:String = {
		if let chemicalName = self.infosXML!["describeHet"]["ligandInfo"]["ligand"]["chemicalName"].element?.text {
			return (chemicalName)
		}
		return ("No chemical name")
	}()
	
	lazy var formula:String = {
		if let formula = self.infosXML!["describeHet"]["ligandInfo"]["ligand"]["formula"].element?.text {
			return (formula)
		}
		return ("No formula")
	}()
	
	private lazy var middleSCNVector3 = SCNVector3()
	private var infosXML:XMLIndexer?
	
	//MARK: - Initializer
	init(nameLigand:String){
		name = nameLigand
	}
	
	convenience init(nameLigand:String, graphicalInfos:String) throws{
		self.init(nameLigand: nameLigand)
		try self.setGraphicalInformation(graphicalInfos)
	}
	//MARK: - Get graphical informations
	func middleVector()->SCNVector3{
		self.atomList.forEach { (atom) in
			var middle = self.middleSCNVector3
			middle.x = (middle.x + atom.x)/2
			middle.y = (middle.y + atom.y)/2
			middle.z = (middle.z + atom.z)/2
			self.middleSCNVector3 = middle
		}
		return (self.middleSCNVector3)
	}

	
	//MARK: - Set graphical informations
	func setGraphicalInformation(infos:String) throws{
		guard (infos != "") else {
			throw LigandError.EmptyInfos
		}
		
		let linesTable = infos.componentsSeparatedByString("\n")
		for line in linesTable{
			if let atom = Atom(lineFile: line){
				atomList.append(atom)
			}
			if let connect = Connect(lineFile: line){
				connectList.append(connect)
			}
		}
		guard infos.containsString("END") else {
			throw LigandError.NoEndKeyword
		}
	}
	
	func setInformation(xml:String){
		infosXML = SWXMLHash.parse(xml)
	}
	
	//MARK: - Specific item
	func atomById(id:Int) -> Atom?{
		for atom in atomList {
			if (atom.id == id){
				return (atom)
			}
		}
		return nil
	}
	
	func atomAt(vector3:SCNVector3) -> Atom?{
		for atom in atomList {
			if (atom.position == vector3){
				return (atom)
			}
		}
		return nil
	}
	
	func connectBySenderId(id:Int) -> Connect?{
		for connect in connectList{
			if (connect.sender == id){
				return (connect)
			}
		}
		return nil
	}
}

infix operator == { precedence 130 }
func == (left: SCNVector3, right: SCNVector3) -> Bool {
	if (left.x == right.x && left.y == right.y && left.z == right.z){
		return (true)
	} else {
		return (false)
	}
}

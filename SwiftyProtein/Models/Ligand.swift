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
	/// Name of the ligand
	var name:String
	
	/// List of atom who compose
	var atomList = [Atom]()
	
	/// List of link between atom
	var connectList = [Connect]()
	
	
	//MARK: - lazy infos
	/// Type family
	lazy var type:String = {
		if let ligandType = self.infosXML!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["type"] {
			return (ligandType)
		}
		return ("No type")
	}()
	
	/// Molecular weight
	lazy var molecularWeight:String = {
		if let molecularWeight = self.infosXML!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["molecularWeight"] {
			return (molecularWeight)
		}
		return ("No molecular weight")
	}()
	
	/// Chemical Name
	lazy var chemicalName:String = {
		if let chemicalName = self.infosXML!["describeHet"]["ligandInfo"]["ligand"]["chemicalName"].element?.text {
			return (chemicalName)
		}
		return ("No chemical name")
	}()
	
	/// Formula
	lazy var formula:String = {
		if let formula = self.infosXML!["describeHet"]["ligandInfo"]["ligand"]["formula"].element?.text {
			return (formula)
		}
		return ("No formula")
	}()
	
	/// private middle SCNVector
	private lazy var middleSCNVector3 = SCNVector3()
	
	/// XML Indexer for rscb ligand database
	private var infosXML:XMLIndexer?
	
	//MARK: - Initializer
	/**
	Initilize Ligand with his name
	- Parameters:
		- nameLigand: Give a name to the Ligand
	*/
	init(nameLigand:String){
		name = nameLigand
	}
	
	/**
	Initilize Ligand with his name and his graphical representation.
	The graphical representation
	- Parameters:
		- nameLigand: Give a name to the Ligand
		- graphicalInfos: String represent the file content found by a request with the `LigandRouter.Representation(<NameLigand>)` Enum on the file.rscb.org API.
	*/
	convenience init(nameLigand:String, graphicalInfos:String) throws{
		self.init(nameLigand: nameLigand)
		try self.setGraphicalInformation(graphicalInfos)
	}
	
	//MARK: - Get graphical informations
	/**
	Middle point the representation in 3D.
	- Returns: SCNVector3 point in middle of all atom coordinate.
	*/
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
	/**
	Fill `Atom` and `Connect` Arrays from a .pdb file.
	- Parameters:
		- infos: File content of a .pdb file.
	- Returns: explanation
	*/
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
	
	//MARK: - Atom research
	/**
	Return `Atom` with the Id define in parameter
	- Parameters:
		- id: id of the `Atom` searched
	- Returns: `Atom` with the given id
	*/
	func atomById(id:Int) -> Atom?{
		for atom in atomList {
			if (atom.id == id){
				return (atom)
			}
		}
		return nil
	}
	
	/**
	Return `Atom` at a specific SCNVector3 position
	- Parameters:
		- vector3: SCNVector3 position of the `Atom`
	- Returns: `Atom` with the given position. Can be `nil`.
	*/
	func atomAt(vector3:SCNVector3) -> Atom?{
		for atom in atomList {
			if (atom.position == vector3){
				return (atom)
			}
		}
		return nil
	}
	
	/**
	Return the first `Atom`, if exist, in SCNHitTestResult Array.
	- Parameters:
		- hitResults: SCNHitTestResult Array of nodes hits
	- Returns: `Atom` founded in SCNHitTestResult Array. Can be `nil`.
	*/
	func findAtomInHitResults(hitResults:[SCNHitTestResult]) -> Atom?{
		if hitResults.count > 0 {
			let result = hitResults[0]
			let node = result.node
			let atomOpt = self.atomAt(node.position)
			if let atom = atomOpt {
				return (atom)
			}
		}
		return (nil)
	}
	
	//MARK: - Connect research
	/**
	Return `Connect` with the Id define in parameter
	- Parameters:
	- id: id of the `Connect` searched
	- Returns: `Connect` with the given id
	*/
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

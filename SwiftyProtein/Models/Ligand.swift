//
//  Ligand.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SWXMLHash

enum LigandError: ErrorType {
	case EmptyInfos
	case NoEndKeyword
}


class Ligand {
	
	// MARK: - Needle
	var name:String
	var atomList = [Atom]()
	var connectList = [Connect]()
	
	//MARK: - Initializer
	init(nameLigand:String){
		name = nameLigand
	}
	
	convenience init(nameLigand:String, graphicalInfos:String) throws{
		self.init(nameLigand: nameLigand)
		try self.setGraphicalInformation(graphicalInfos)
	}
	
	//MARK: - Set graphical informations
	func setGraphicalInformation(infos:String) throws{
		guard (infos != "") else {
			throw LigandError.EmptyInfos
		}
		
		let linesTable = infos.componentsSeparatedByString("\n")
		for line in linesTable{
			if let atom = fillAtom(line){
				atomList.append(atom)
			}
			if let connect = fillConnect(line){
				connectList.append(connect)
			}
		}
		guard infos.containsString("END") else {
			throw LigandError.NoEndKeyword
		}
	}
	
	private func fillAtom(line:String) -> Atom? {
		if (line != ""){
			let data = line.componentsSeparatedByString(" ")
			if data.count == 12 && data[0] == "ATOM" {
				return (Atom(lineFile: line))
			}
		}
		return (nil)
	}
	
	private func fillConnect(line:String) -> Connect? {
		if (line != ""){
			let data = line.componentsSeparatedByString(" ")
			if data.count == 12 && data[0] == "CONNECT" {
				return Connect(lineFile: line)
			}
		}
		return (nil)
	}
}

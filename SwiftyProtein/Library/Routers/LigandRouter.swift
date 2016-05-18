//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

/**
Url path from RCBS.org RESTApi about Ligand description Het
- `Read`: get the string of Ligand .pdb file.
*/
enum LigandRouter: ApiRouter {

	/**
	Read informations case
	*/
	case Read(String)
	
	/**
	Read representation of a ligand in 3d space
	*/
	case Representation(String)
	
	/**
	- .Read, .Representation = .GET
	*/
	var method: Alamofire.Method {
		switch self {
		case .Read:
			return .GET
		case .Representation:
			return .GET
		}
	}
	
	/**
	- .Read = /pdb/rest/describeHet
	- .Representation = ligands/download/
	*/
	var path: String {
		switch self {
		case .Read:
			return "/pdb/rest/describeHet"
		case .Representation:
			return "ligands/download/"
		}
	}
	
	/**
	- .Read(let ligandName) = ?chemicalID=\(ligandName)
	- .Representation = \(ligandName)_model.pdb
	*/
	var parameters:String{
		switch self {
		case .Read(let ligandName):
			return "?chemicalID=\(ligandName)"
		case .Representation(let ligandName):
			return "\(ligandName)_model.pdb"
		}
	}
	
	/**
	- .Read(let ligandName) = http://www.rcsb.org/
	- .Representation = http://file.rcsb.org/
	*/
	var baseUrl:String{
		switch self {
		case .Read:
			return "http://www.rcsb.org/"
		case .Representation:
			return "http://file.rcsb.org/"
		}
	}
}

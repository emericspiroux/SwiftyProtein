//
//  UserRoute.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//

import Alamofire

enum LigandRouter: ApiRouter {

	case Read(String)
	
	// MARK: Depend on Case proprieties
	var method: Alamofire.Method {
		switch self {
		case .Read:
			return .GET
		}
	}
	
	var path: String {
		switch self {
		case .Read:
			return "/pdb/rest/describeHet"
		}
	}
	
	var parameters:String{
		switch self {
		case .Read(let ligandName):
			return "?chemicalID=\(ligandName)"
		}
	}
	
	
	// MARK: - ApiRouter methods
	/*
	** return complete path of api
	*/
	func route() -> (Method, String, String)
	{
		return (method, path, parameters)
	}
}

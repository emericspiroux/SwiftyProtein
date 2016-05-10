//
//  Protocol.swift
//  correct42
//
//  Created by larry on 27/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire

/*
** Allow ApiRequester to use route to know path and method of the request 
*/

protocol ApiRouter {
	func route() -> (Method, String, String)
	var method:Method{get}
	var path:String{get}
	var parameters:String{get}
}

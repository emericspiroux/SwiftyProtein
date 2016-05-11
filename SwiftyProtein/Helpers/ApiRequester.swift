//
//  APIManager.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire
import SWXMLHash

class ApiRequester {
	
	//MARK: - Singleton
	static let sharedInstance = ApiRequester()
	
	static func Shared() -> ApiRequester
	{
		return (self.sharedInstance)
	}
	
	//MARK: - Proprieties
	var baseURLString = "http://www.rcsb.org/"
	
	//MARK: - Methods
	/*
	** Send request to api server with a router Enum and execute callback.
	*/
	func request(router:ApiRouter, success: (String)->Void, failure:(NSError)->Void)
	{
		Alamofire.request(router.method, "\(baseURLString)\(router.path)\(router.parameters)")
			.responseString{ reponse in
				if let stringData = reponse.result.value{
					success(stringData);
				} else {
					failure(NSError(domain: "Data formating failed", code: -1, userInfo: nil))
				}
			}
	}
	
	/*
	** download an image and return NSUTF8String image data
	*/
	func downloadPdb(pdbName:String, success:(String)->Void, failure:(NSError)->Void){
		Alamofire.request(.GET, "http://files.rcsb.org/ligands/download/\(pdbName)_model.pdb").response() {
			(_, _, data, _) in
			if let data = data{
				let fileContent = String.init(data: data, encoding: NSUTF8StringEncoding)
				if let content = fileContent{
					success(content)
				} else {
					failure(NSError(domain: "File content is empty", code: -1, userInfo: nil))
				}
			} else {
				failure(NSError(domain: "Error on download pdbFile", code: -1, userInfo: nil))
			}
		}
		
	}
}


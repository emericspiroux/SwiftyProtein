//
//  APIManager.swift
//  correct42
//
//  Created by larry on 26/04/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Alamofire
import SWXMLHash


/// Make a request to the server API.
class ApiRequester {
	
	//MARK: - Singleton
	static let sharedInstance = ApiRequester()
	
	/**
	Give the singleton object of the ApiRequester
	
	```
		let apiRequester = APIRequester.Shared()
	```
	
	- returns: `static let sharedInstance`
	*/
	static func Shared() -> ApiRequester
	{
		return (self.sharedInstance)
	}
	
	//MARK: - Methods
	/**
	Send request to api server with an APIRouter inheritance Enum and execute callback.
	
		let apiRequester = APIRequester.Shared()
		apiRequester.request(LigandRouter.Read("NAG"), success:
		{ (fileContent) in
			print(fileContent)
		}
		}) { (error) in
			print(error)
		}

	
	- Parameters:
		- router: ApiRouter protocol. Give the url of the ressource.
		- success: CallBack execute if the request success.
		- failure: CallBack execute if the request fail.
	*/
	func request(router:ApiRouter, success: (String)->Void, failure:(NSError)->Void)
	{
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		Alamofire.request(router.method, "\(router.baseUrl)\(router.path)\(router.parameters)")
			.responseString{ reponse in
				if let stringData = reponse.result.value{
					success(stringData);
				} else {
					failure(NSError(domain: "Data formating failed", code: -1, userInfo: nil))
				}
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}
	}
	
	/**
	Download a file from an ApiRouter inheritance Enum and execute callback.
	
		let apiRequester = APIRequester.Shared()
		apiRequester.downloadFile(LigandRouter.Representation("NAG"), success:
		{ (fileContent) in
			print(fileContent)
		}
		}) { (error) in
			print(error)
		}
	
	- Parameters:
		- router: ApiRouter protocol. Give the url of the ressource.
		- success: CallBack execute if the request success, take String for the content of the File.
		- failure: CallBack execute if the request fail.
	*/
	func downloadFile(router:ApiRouter, success:(String)->Void, failure:(NSError)->Void){
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		Alamofire.request(router.method, "\(router.baseUrl)\(router.path)\(router.parameters)").response() {
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
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
		}
		
	}
}


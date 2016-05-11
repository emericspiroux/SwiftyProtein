//
//  Connect.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

class Connect {
	var data:[String]
	
	lazy var count:Int = {
		return (self.data.count - 1)
	}()
	
	lazy var sender:Int? = {
		return (Int(self.data[1]))
	}()
	
	lazy var receiver:[Int] = {
		var IdsReceivers = [Int]()
		for i in 2..<self.data.count{
			if let newReceiver = Int(self.data[i]){
				IdsReceivers.append(newReceiver)
			}
		}
		return (IdsReceivers)
	}()
	
	init(lineFile:String){
		data = lineFile.componentsSeparatedByString(" ")
	}
}



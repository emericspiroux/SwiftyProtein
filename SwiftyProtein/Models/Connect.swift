//
//  Connect.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

/// Represent a link between two Atom.
class Connect {
	
	// MARK: - Raw data
	/// Exploded line without space
	var data:[String]
	
	// MARK: - Proprieties
	/// Count connections
	lazy var count:Int = {
		return (self.data.count - 1)
	}()
	
	/// Sender atom Id
	lazy var sender:Int? = {
		return (Int(self.data[1]))
	}()
	
	/// Array of receiver atom Id
	lazy var receiver:[Int] = {
		var IdsReceivers = [Int]()
		for i in 2..<self.data.count{
			if let newReceiver = Int(self.data[i]){
				IdsReceivers.append(newReceiver)
			}
		}
		return (IdsReceivers)
	}()
	
	// MARK: - Initializer
	/**
	Initialize optional connect model with a line with keyword CONECT
	- Parameter lineFile: Line of a .pdb file from rcsb ligand database.
	*/
	init?(lineFile:String){
		let dataFiltered = lineFile.componentsSeparatedByString(" ").filter{$0 != ""}
		guard (dataFiltered.count > 0 && dataFiltered[0] == "CONECT") else {
			return nil
		}
		data = dataFiltered
	}
}



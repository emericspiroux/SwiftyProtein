//
//  ListLigand.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Foundation

/// Singleton List Ligand manager
class ListLigand {
	// MARK: - Singleton
	/// static Instance of the listLigand Manager
	static let instance = ListLigand()
	
	/**
	Give the singleton object of the ListLigand
	
	```
	let listLigand = ListLigand.Shared()
	```
	
	- returns: `static let instance`
	*/
	static func Shared() -> ListLigand{
		return (instance)
	}
	
	
	// MARK: - Needed
	/// Array of ligands
	var listLigands = [Ligand]()
	
	/**
	Initialize the list by ftching ressources in the `Ressources/ligands.txt`
	*/
	init(){
		fetchLigands()
	}
	
	/**
	Read ligands name in `Ressources/ligands.txt` and fill the listLigand var
	*/
	private func fetchLigands(){
		if let filepath = NSBundle.mainBundle().pathForResource("ligands", ofType: "txt") {
			do {
				let fileContent = try NSString(contentsOfFile: filepath, usedEncoding: nil) as String
				let namesLigands = fileContent.componentsSeparatedByString("\n")
				for nameLigand in namesLigands {
					listLigands.append(Ligand(nameLigand: nameLigand))
				}

			} catch {
				print("could not be opened")
			}
		} else {
			print("not found")
		}
	}
}

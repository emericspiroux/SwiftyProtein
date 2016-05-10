//
//  ListLigand.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import Foundation

class ListLigand {
	// MARK: - Singleton
	static let instance = ListLigand()
	
	static func Shared() -> ListLigand{
		return (instance)
	}
	
	
	// MARK: - Needed
	var listLigands = [Ligand]()
	
	init(){
		fetchLigands()
	}
	
	func fetchLigands(){
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
	
	func getSection() -> ([String],[[Ligand]]){
		var sectionedLigand = [[Ligand]]()
		var tmpLigand = [Ligand]()
		var firstChar = listLigands.first?.name.characters.first
		var sectionedChar = [String]()
		sectionedChar.append("\(firstChar)")
		
		for listLigand in listLigands{
			if (listLigand.name.characters.first == firstChar){
				tmpLigand.append(listLigand)
			} else {
				sectionedLigand.append(tmpLigand)
				tmpLigand.removeAll()
				firstChar = listLigand.name.characters.first
				sectionedChar.append("\(firstChar)")
				tmpLigand.append(listLigand)
			}
		}
		if (tmpLigand.count != 0){
			sectionedLigand.append(tmpLigand)
		}
		return ((sectionedChar,sectionedLigand))
	}
	
}

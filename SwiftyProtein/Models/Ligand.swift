//
//  Ligand.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import SWXMLHash

class Ligand {
	
	// MARK: - Needle
	var xml:XMLIndexer?
	var name:String
	
	//MARK: - Lazy proprieties, need xml or allways fail
	lazy var script:String? = {
		if let attribute = self.xml!["describeHet"]["script"].element?.attributes["id"] {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var chemicalID:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["chemicalID"] {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var chemicalName:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"]["chemicalName"].element?.text! {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var type:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["type"] {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var molecularWeight:Int? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"].element?.attributes["molecularWeight"] {
			return (Int(attribute))
		}
		return (nil)
	}()
	
	lazy var formula:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"]["formula"].element?.text! {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var InChIKey:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"]["InChIKey"].element?.text! {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var inChI:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"]["InChI"].element?.text! {
			return (attribute)
		}
		return (nil)
	}()
	
	lazy var smiles:String? = {
		if let attribute = self.xml!["describeHet"]["ligandInfo"]["ligand"]["smiles"].element?.text! {
			return (attribute)
		}
		return (nil)
	}()
	
	//MARK: - Initializer
	init(nameLigand:String){
		name = nameLigand
	}
	
	convenience init(nameLigand:String, xmlParse:String){
		self.init(nameLigand: nameLigand)
		xml = SWXMLHash.parse(xmlParse)
	}
	
	//MARK: - Setter String XML to Dictionnary
	func setXMLString(xmlParse:String){
		xml = SWXMLHash.parse(xmlParse)
	}
}

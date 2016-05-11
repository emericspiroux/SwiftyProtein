//
//  ProteinListViewController.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class ProteinListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

	@IBOutlet weak var searchLigandBar: UISearchBar!
	@IBOutlet weak var tableLigand: UITableView!
	@IBOutlet weak var searchLigand: UISearchBar!
	
	var selectedLigan:Ligand? = nil
	var listLigand = ListLigand.Shared().listLigands
	var apiRequester = ApiRequester.Shared()
	
	let cellName = "LigandCell"
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		let cell = UINib(nibName: cellName, bundle: nil)
		tableLigand.registerNib(cell, forCellReuseIdentifier: cellName)
		tableLigand.delegate = self
		tableLigand.dataSource = self
		searchLigand.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//MARK: - Other methods
	func searchValue(value:String){
		listLigand = ListLigand.Shared().listLigands
		if (value != ""){
			listLigand = listLigand.filter{$0.name.containsString(value.uppercaseString)}
		}
		tableLigand.reloadData()
	}
	
	//MARK: - Search Bar delegation
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		searchValue(searchText)
	}
	
	//MARK: - Table
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (listLigand.count)
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let ligandListCellPrototype:LigandTableViewCell? = {
			let ligandCell = self.tableLigand.dequeueReusableCellWithIdentifier(self.cellName)
			if ligandCell is LigandTableViewCell{
				return (ligandCell as! LigandTableViewCell)
			}
			return (nil)
		}()
		ligandListCellPrototype?.nameLabel.text = listLigand[indexPath.row].name
		return (ligandListCellPrototype!)
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		apiRequester.downloadPdb(listLigand[indexPath.row].name, success:
		{ (fileContent) in
			do{
				try self.listLigand[indexPath.row].setGraphicalInformation(fileContent)
				showAlertWithTitle("Ligand", message: "Next Step !", view: self)
			} catch LigandError.EmptyInfos {
				showAlertWithTitle("Ligand", message: "Infos retrived are empty", view: self)
			} catch LigandError.NoEndKeyword {
				showAlertWithTitle("Ligand", message: "No end in file detected, maybe some data will be not display", view: self)
			} catch {
				showAlertWithTitle("Ligand", message: "Unknown Error", view: self)
			}
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
		}) { (error) in
				UIApplication.sharedApplication().networkActivityIndicatorVisible = false
				showAlertWithTitle("RCSB", message: "Network Problem occured, please check your connection and try again.", view: self)
		}
	}
}

//
//  ProteinListViewController.swift
//  SwiftyProtein
//
//  Created by larry on 10/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

/**
Display a Table view with the file Ligands.txt lines.
Display search bar to filter table entries.
*/
class ProteinListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	// MARK: - Proprieties
	/// TableView delegate in the ProteinListViewController.
	@IBOutlet weak var tableLigand: UITableView!
	
	/// Textfield for search in the `listLigand` array.
	@IBOutlet weak var searchLigand: UISearchBar!
	
	/// Lignd selected in the tableView `tableLigand`.
	var selectedLigan:Ligand? = nil
	
	/// List of all ligands in the singleton `ListLigand`.
	var listLigand = ListLigand.Shared().listLigands
	
	/// Instance of the singleton `ApiRequester`.
	var apiRequester = ApiRequester.Shared()
	
	/// Index of the listLigand selected in `tableLigand`.
	var selectedIndexRow:Int?
	
	/// Name of the custom cell
	let cellName = "LigandCell"
	
	// MARK: - View overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		loadCustomCell()
		loadDelegate()
    }
	
	// MARK: - Private Method
	/**
	Filter the `listLigand` by name
	if the `value` is empty, all the list will be load
	
	- Parameter value : the ligand name search
	*/
	private func searchValue(value:String){
		listLigand = ListLigand.Shared().listLigands
		if (value != ""){
			listLigand = listLigand.filter{$0.name.containsString(value.uppercaseString)}
		}
	}

	/**
	Load custom cell with the name of `cellName` const
	*/
	private func loadCustomCell(){
		let cell = UINib(nibName: cellName, bundle: nil)
		tableLigand.registerNib(cell, forCellReuseIdentifier: cellName)
	}
	
	/**
	Load delegation :
	
	- `tableLigand`: dataSource and delegate
	- `searchLigand`: delegate
	*/
	private func loadDelegate(){
		tableLigand.delegate = self
		tableLigand.dataSource = self
		searchLigand.delegate = self
	}
	
	//MARK: - Button Actions
	/**
	Dismiss the ProteinListView
	
	- Parameter sender: UIButton touched in
	*/
	@IBAction func cancelTabBarButton(sender: UIBarButtonItem) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	// MARK: - Search Bar delegation
	/**
	Execute when the user type in the textfield UISearchBar.
	Use the function searchBar and reload data of tableLigand.
	
	- Parameter 
		- searchBar: the ligand name search
		- searchText: new text type in the UISearchBar
	*/
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		searchValue(searchText)
		tableLigand.reloadData()
	}
	
	// MARK: - Table
	/**
	Return the number of ligand in `listLigand` in ListLigand for the `tableLigand`
	*/
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (listLigand.count)
	}
	
	/**
	Fill the `LigandCell` custom cell with the name of the ligand at `indexPath.row` in `listLigand`
	*/
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
	
	/**
	Call the API requester to get the ligand representation when the row is selected.
	
		- Success : if all was present, the `selectedIndexRow` will be set for the preparation of the segue and perform the segue "goToSceneKit", otherwise show the appropriate alert. If END keyword was not found, the scene will be load but a warning alert will explain the fact.
		- Fail : Show an Alert about connection problems
	*/
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if (UIApplication.sharedApplication().networkActivityIndicatorVisible == false){
			apiRequester.downloadFile(LigandRouter.Representation(listLigand[indexPath.row].name), success:
				{ (fileContent) in
					do{
						try self.listLigand[indexPath.row].setGraphicalInformation(fileContent)
						self.selectedIndexRow = indexPath.row
						self.performSegueWithIdentifier("goToSceneKit", sender: self)
					} catch LigandError.EmptyInfos {
						showAlertWithTitle("Ligand", message: "Infos retrived are empty", view: self)
					} catch LigandError.NoEndKeyword {
						showAlertWithTitle("Ligand", message: "No end in file detected, maybe some data will be not display", view: self)
						self.selectedIndexRow = indexPath.row
						self.performSegueWithIdentifier("goToSceneKit", sender: self)
					} catch {
						showAlertWithTitle("Ligand", message: "Unknown Error", view: self)
					}
			}) { (error) in
					showAlertWithTitle("RCSB", message: "Network Problem occured, please check your connection and try again.", view: self)
			}
		}
	}
	
	//MARK: - Segue preparation
	/**
	if the destinationViewController is :
		- SceneKitViewController : Fill the SceneKitViewController's ligand object with the selected ligand if exist.
	*/
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let destinationController = segue.destinationViewController
		if destinationController is SceneKitViewController {
			if let indexRow = selectedIndexRow {
				(destinationController as! SceneKitViewController).ligand = listLigand[indexRow]
			}
		}
	}
}

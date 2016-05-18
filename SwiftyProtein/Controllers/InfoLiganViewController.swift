//
//  InfoLiganViewController.swift
//  SwiftyProtein
//
//  Created by larry on 14/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class InfoLiganViewController: UIViewController {

	/// Chemical id label of the ligand
	@IBOutlet weak var chemicalId: UILabel!
	/// Chemical name label of the ligand
	@IBOutlet weak var chemicalName: UILabel!
	/// Type label of the ligand
	@IBOutlet weak var type: UILabel!
	/// Molecular weight label of the ligand
	@IBOutlet weak var molecularWeight: UILabel!
	/// Formula label of the ligand
	@IBOutlet weak var formula: UILabel!
	
	/// Ligand object
	var ligand:Ligand?
	
	/// Fill informations when view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		fillAtomInformation()
    }
	
	/**
	Fill informations in `chemicalId`, `chemicalName`, `type`, `molecularWeight` and `formula` if ligand exist.
	*/
	private func fillAtomInformation(){
		if (ligand != nil){
			chemicalId.text = ligand!.name
			chemicalName.text = ligand!.chemicalName
			type.text = "Type:\n\(ligand!.type)"
			molecularWeight.text = "Molecular weight:\n\(ligand!.molecularWeight)"
			formula.text = "Formula:\n\(ligand!.formula)"
		}
	}
	
	/**
	Dismiss the present view controller
	
	- Parameter sender: Any `UIButton`
	*/
	@IBAction func backButton(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}

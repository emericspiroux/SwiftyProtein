//
//  InfoLiganViewController.swift
//  SwiftyProtein
//
//  Created by larry on 14/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit

class InfoLiganViewController: UIViewController {

	@IBOutlet weak var chemicalId: UILabel!
	@IBOutlet weak var chemicalName: UILabel!
	@IBOutlet weak var type: UILabel!
	@IBOutlet weak var molecularWeight: UILabel!
	@IBOutlet weak var formula: UILabel!
	
	var ligand:Ligand?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		if (ligand != nil){
			chemicalId.text = ligand!.name
			chemicalName.text = ligand!.chemicalName
			type.text = "Type:\n\(ligand!.type)"
			molecularWeight.text = "Molecular weight:\n\(ligand!.molecularWeight)"
			formula.text = "Formula:\n\(ligand!.formula)"
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func backButton(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

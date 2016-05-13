//
//  SceneKitViewController.swift
//  SwiftyProtein
//
//  Created by larry on 11/05/2016.
//  Copyright © 2016 42. All rights reserved.
//
import UIKit
import SceneKit

class SceneKitViewController: UIViewController {

	var ligand:Ligand?
	var apiRequester = ApiRequester.Shared()

	@IBOutlet weak var ligandScene: SCNView!
	@IBOutlet weak var atomSelectedLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		ligandScene.hidden = true
	}
	
	override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view
		
		//Prepare scene view
		//ligandScene.backgroundColor = UIColor.fromRGB(0xF9F9F9)
		ligandScene.autoenablesDefaultLighting = true
		ligandScene.allowsCameraControl = true
		
		//if draw pass correctly pass to the view
		if (ligand == nil){
			showAlertWithTitle("Ligand", message: "No ligand loaded", view: self)
		} else {
			ligandScene.scene = LigandScene(ligand: ligand!, model: modelScene.stickBall)
		}
		
		//prepare view component
		self.title = ligand?.name
		atomSelectedLabel.text = ""
		atomSelectedLabel.textColor = UIColor.fromRGB(0x3F4149)
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(true)
		ligandScene.hidden = false
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func SceneTapped(sender: UITapGestureRecognizer) {
		let location = sender.locationInView(ligandScene)
		let hitResults = ligandScene.hitTest(location, options: nil)
		var resultFinded = true
		if hitResults.count > 0 {
			let result = hitResults[0]
			let node = result.node
			if (ligand != nil){
				let atomOpt = ligand!.atomAt(node.position)
				if let atom = atomOpt {
					atomSelectedLabel.text = "Atom selected\n\(atom.type) - \(atom.details.stringByReplacingOccurrencesOfString(atom.type, withString: ""))"
					resultFinded = false
				}
			}
		}
		if (resultFinded) {
			atomSelectedLabel.text = ""
		}
		
	}
	
	@IBAction func shareScene(sender: UIButton) {
		
		if let ligandName = ligand?.name{
			let objectsToShare = [ligandName, ligandScene.snapshot()]
			let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
			
			//New Excluded Activities Code
			activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
			
			activityVC.popoverPresentationController?.sourceView = sender
			self.presentViewController(activityVC, animated: true, completion: nil)
		} else {
			showAlertWithTitle("Ligand Scene", message: "no ligand data", view: self)
		}
	}
	
	@IBAction func changeModel(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex{
		case 0:
			ligandScene.scene = LigandScene(ligand: ligand!, model: modelScene.stickBall)
		case 1:
			ligandScene.scene = LigandScene(ligand: ligand!, model: modelScene.radius)
		default:
			ligandScene.scene = LigandScene(ligand: ligand!, model: modelScene.stickBall)
		}
	}
	
	
	@IBAction func showInformations(sender: UIButton) {
		apiRequester.request(LigandRouter.Read(ligand!.name), success: { (xml) in
			self.ligand?.setInformation(xml)
			self.performSegueWithIdentifier("goToInformation", sender: self)
			}) { (error) in
				showAlertWithTitle("Ligand", message: "Error on fetching informations", view: self)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.destinationViewController is InfoLiganViewController{
			(segue.destinationViewController as! InfoLiganViewController).ligand = ligand
		}
	}
	
}

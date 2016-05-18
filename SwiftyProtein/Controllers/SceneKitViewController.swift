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
	
	// MARK: - Proprieties
	/// Ligand display in the `ligandScene`
	var ligand:Ligand?
	
	/// Instance of the singleton `ApiRequester`.
	var apiRequester = ApiRequester.Shared()

	/// The `SCNView` where we'll display the ligand representation
	@IBOutlet weak var ligandScene: SCNView!
	
	/// Display the detail of the selected atom on the `ligandScene`
	@IBOutlet weak var atomSelectedLabel: UILabel!
	
	
	// MARK: - View overrides
	/**
	Set the ligandScene alpha to 0 because SceneKit diplaying bug.
	*/
	override func viewDidLoad() {
		super.viewDidLoad()
		ligandScene.alpha = 0.0
		
	}
	
	override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view
		prepareLigandScene()
		prepareViewComponents()
    }
	
	/**
	Animate smoothly the displaying of ligandScene when the scene is load
	*/
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		if (animated){
			UIView.animateWithDuration(0.5, animations: {
				self.ligandScene.alpha = 1.0
			})
		} else {
			ligandScene.alpha = 1.0
		}
	}
	
	// MARK: - private Methods
	/**
	Prepare the ligandScene
	
	1. Enable the defaultLighting.
	2. allow camera control.
	3. load `LigandScene` object in the `ligandScene`'s scene propriety.
	*/
	private func prepareLigandScene(){
		//Prepare scene view
		ligandScene.autoenablesDefaultLighting = true
		ligandScene.allowsCameraControl = true
		
		//if draw pass correctly pass to the view
		if (ligand == nil){
			showAlertWithTitle("Ligand", message: "No ligand data loaded", view: self)
		} else {
			ligandScene.scene = LigandScene(ligand: ligand!, model: modelScene.stickBall)
		}
	}
	
	/**
	Prepare view components
	
	1. Set ligand name as title
	2. Set the color of the `atomSelectedLabel` to light grey
	3. Put the `atomSelectedLabel` empty
	
	*/
	private func prepareViewComponents(){
		self.title = ligand?.name
		atomSelectedLabel.textColor = UIColor.fromRGB(0x3F4149)
		atomSelectedLabel.text = ""
	}
	
	/**
	Display in `atomSelectedLabel` the selected atom's
	name by user locate in SCNHitTestResult otherwise hide the label.
	
	- Parameter hitResults: [SCNHitTestResult] in the ligandScene
	*/
	private func displaySelectedAtomInformations(hitResults:[SCNHitTestResult]){
		if (ligand != nil){
			if let atom = ligand?.findAtomInHitResults(hitResults){
				atomSelectedLabel.text = "Atom selected\n\(atom.type) - \(atom.details)"
			} else {
				atomSelectedLabel.text = ""
			}
		}
	}
	
	// MARK: - Scene delegation
	@IBAction func SceneTapped(sender: UITapGestureRecognizer) {
		let location = sender.locationInView(ligandScene)
		let hitResults = ligandScene.hitTest(location, options: nil)
		displaySelectedAtomInformations(hitResults)
	}
	
	// MARK: - Buttons
	/**
	Display the popover view for share a snapshot of the `LigandScene`
	
	- Parameter sender: Any `UIButton`
	*/
	@IBAction func shareScene(sender: UIButton) {
		
		if let ligandName = ligand?.name{
			let objectsToShare = [ligandName, ligandScene.snapshot()]
			let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
			
			//New Excluded Activities Code
			activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
			activityVC.popoverPresentationController?.sourceView = sender
			
			self.presentViewController(activityVC, animated: true, completion: nil)
		} else {
			showAlertWithTitle("Ligand Scene", message: "No ligand data loaded", view: self)
		}
	}
	
	/**
	Perform the segue "goToInformation" after catching informations about ligand and put it in `ligand` model presently show.
	if request fail view controller display an Alert.
	
	- Parameter sender: Any `UIButton`
	*/
	@IBAction func showInformations(sender: UIButton) {
		apiRequester.request(LigandRouter.Read(ligand!.name), success: { (xml) in
			self.ligand?.setInformation(xml)
			self.performSegueWithIdentifier("goToInformation", sender: self)
		}) { (error) in
			showAlertWithTitle("Ligand", message: "Error on fetching informations", view: self)
		}
	}
	
	// MARK: - Segment Controll
	/**
	Change the `ligandScene.scene`
	with this model options compared with `selectedSegmentIndex` :
	
	case 0 : `modelScene.stickBall`
	
	case 1 : `modelScene.radius`

	Default : `modelScene.stickBall`
	
	- Parameter sender: Any `UISegmentedControl`
	*/
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
	
	// MARK: - Segue Prepare
	/**
	if the destinationViewController is :
		- InfoLiganViewController : Fill the InfoLiganViewController's ligand object
	*/
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.destinationViewController is InfoLiganViewController{
			(segue.destinationViewController as! InfoLiganViewController).ligand = ligand
		}
	}
	
}

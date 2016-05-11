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
	
	@IBOutlet weak var ligandScene: SCNView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
		ligandScene.backgroundColor = UIColor.fromRGB(0xCCFFFF)
		ligandScene.autoenablesDefaultLighting = true
		ligandScene.allowsCameraControl = true
		if (ligand == nil){
			showAlertWithTitle("Ligand", message: "No ligand loaded", view: self)
		} else {
			ligandScene.scene = LigandScene(ligand: ligand!)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

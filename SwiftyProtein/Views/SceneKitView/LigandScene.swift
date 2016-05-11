//
//  LigandScene.swift
//  SwiftyProtein
//
//  Created by larry on 11/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SceneKit

class LigandScene: SCNScene {
	
	init(ligand:Ligand) {
		super.init()
		drawLigand(ligand)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func drawLigand(ligand:Ligand){
		for atom in ligand.atomList{
			let sphereGeometry = SCNSphere(radius: 0.5)
			sphereGeometry.firstMaterial?.diffuse.contents = atom.color
			let sphereNode = SCNNode(geometry: sphereGeometry)
			sphereNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
			self.rootNode.addChildNode(sphereNode)
		}
	}
}

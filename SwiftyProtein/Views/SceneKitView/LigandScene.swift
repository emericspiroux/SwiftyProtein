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
		drawAtom(ligand.atomList)
		drawConnect(ligand)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func drawAtom(atomList:[Atom]){
		for atom in atomList{
			let sphereGeometry = SCNSphere(radius: 0.5)
			sphereGeometry.firstMaterial?.diffuse.contents = atom.color
			let sphereNode = SCNNode(geometry: sphereGeometry)
			sphereNode.position = SCNVector3(x: atom.x, y: atom.y, z: atom.z)
			self.rootNode.addChildNode(sphereNode)
		}
	}
	
	func drawConnect(ligand:Ligand){
		for connect in ligand.connectList{
			if let senderId = connect.sender{
				if let sender = ligand.atomById(senderId){
					for receiverId in connect.receiver {
						if let receiver = ligand.atomById(receiverId){
							let heightTube = sender.distance(receiver)
							let middleposition = sender.middlePoint(receiver)
							let tubeGeometry = SCNTube(innerRadius: 0.0, outerRadius: 0.2, height: heightTube)
							tubeGeometry.firstMaterial?.diffuse.contents = UIColor.darkGrayColor()
							let tubeNode = SCNNode(geometry: tubeGeometry)
							tubeNode.position = middleposition
							//tubeNode.eulerAngles = find euler angle calculation
							self.rootNode.addChildNode(tubeNode)
						}
					}
				}
			}
		}
	}
}

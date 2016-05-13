//
//  LigandScene.swift
//  SwiftyProtein
//
//  Created by larry on 11/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SceneKit

enum modelScene{
	case stickBall
	case radius
}

class LigandScene: SCNScene {
	
	var model:modelScene = .stickBall
	
	init(ligand:Ligand, model:modelScene) {
		super.init()
		
		self.model = model
		let node = SCNNode()
		node.camera = SCNCamera()
		self.rootNode.addChildNode(node)

		let middleView = ligand.middleVector()
		node.position = SCNVector3(x:  middleView.x, y: middleView.y, z: middleView.z + 25)

		drawAtom(ligand.atomList)
		drawConnect(ligand)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func drawAtom(atomList:[Atom]){
		for atom in atomList{
			var atomRadius:CGFloat = 0.5
			if model == .radius{
				atomRadius = (CGFloat(atom.atomRadius)/100)
			}
			let sphereGeometry = SCNSphere(radius: atomRadius)
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
							let CylNode = LineNode(
								parent: self.rootNode,
								v1:	SCNVector3(x:sender.x, y:sender.y, z:sender.z),
								v2: SCNVector3(x:receiver.x, y:receiver.y, z:receiver.z),
								radius: 0.2,
								radSegmentCount: 6,
								color: UIColor.darkGrayColor()
								)
								self.rootNode.addChildNode(CylNode)
						}
					}
				}
			}
		}
	}
}

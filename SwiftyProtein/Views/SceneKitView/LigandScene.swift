//
//  LigandScene.swift
//  SwiftyProtein
//
//  Created by larry on 11/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import SceneKit

/**
Choice of the model scene representation
	- stickBall: stick-and-balls model
	- radius: Van Der Waals Radius representation
*/
enum modelScene{
	case stickBall
	case radius
}

///Create a Scene with Ligand Model
class LigandScene: SCNScene {
	
	/// model used for the representation
	var model:modelScene = .stickBall
	
	/// ligand model
	var ligand:Ligand
	
	/**
	Initializator of the ligand scene
	
	```
	mySceneKit.scene = LigandScene(ligand: myligand, model: modelScene.stickBall)
	```
	- Parameters:
		- ligand: ligand model, must contain Atoms list to draw something.
		- model: model based from Enum `modelScene`
	*/
	init(ligand:Ligand, model:modelScene) {
		self.ligand = ligand
		self.model = model
		
		super.init()
		
		initCamera()
		drawAtom()
		drawConnect()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/**
	private initializator of the camera
	*/
	private func initCamera(){
		let node = SCNNode()
		node.camera = SCNCamera()
		self.rootNode.addChildNode(node)
		
		let middleView = ligand.middleVector()
		node.position = SCNVector3(x:  middleView.x, y: middleView.y, z: middleView.z + 25)
	}
	
	/**
	private drawing function for all the Atoms contains in ligand
	*/
	private func drawAtom(){
		for atom in ligand.atomList{
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

	/**
	private drawing function for all the link between atoms contains in ligand
	*/
	private func drawConnect(){
		for connect in ligand.connectList{
			if let senderId = connect.sender{
				if let sender = ligand.atomById(senderId){
					for receiverId in connect.receiver {
						if let receiver = ligand.atomById(receiverId){
							let CylNode = LineNode(
								parent: self.rootNode,
								source:	SCNVector3(x:sender.x, y:sender.y, z:sender.z),
								destination: SCNVector3(x:receiver.x, y:receiver.y, z:receiver.z),
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

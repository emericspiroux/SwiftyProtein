//
//  LineNode.swift
//  SwiftyProtein
//
//  Created by larry on 12/05/2016.
//  Copyright © 2016 42. All rights reserved.
//

import UIKit
import SceneKit

/// Line represent by a cylinder between two points
class LineNode: SCNNode
{
	// MARK: - Initializer
	/**
	Initializes the `LineNode` between two points
	
	```
	let CylNode = LineNode(
		parent: self.rootNode,
		v1:	SCNVector3(x:sender.x, y:sender.y, z:sender.z),
		v2: SCNVector3(x:receiver.x, y:receiver.y, z:receiver.z),
		radius: 0.2,
		radSegmentCount: 6,
		color: UIColor.darkGrayColor()
	)
	mySCNScene.rootNode.addChildNode(CylNode)
	```
	
	- Parameters:
		- parent: Needed to add node to your SceneKit
		- source: Source point of the line
		- destination: Destination point of the line
		- radius: SCNCylinder initializator need a radius
		- radSegmentCount: SCNCylinder definition for the number of segment for the cylinder
	*/
	init( parent: SCNNode,
		source: SCNVector3,
		destination: SCNVector3,
		radius: CGFloat,//somes option for the cylinder
		radSegmentCount: Int, //other option
		color: UIColor )// color of your node object
	{
		super.init()
		
		//Calcul the height of our line
		let  height = source.distance(destination)
		
		//set position to v1 coordonate
		position = source
		
		//Create the second node to draw direction vector
		let nodeDestination = SCNNode()
		
		//define his position
		nodeDestination.position = destination
		//add it to parent
		parent.addChildNode(nodeDestination)
		
		//Align Z axis
		let zAlign = SCNNode()
		zAlign.eulerAngles.x = Float(M_PI_2)
		
		//create our cylinder
		let cyl = SCNCylinder(radius: radius, height: CGFloat(height))
		cyl.radialSegmentCount = radSegmentCount
		cyl.firstMaterial?.diffuse.contents = color
		
		//Create node with cylinder
		let nodeCyl = SCNNode(geometry: cyl )
		nodeCyl.position.y = -height/2
		zAlign.addChildNode(nodeCyl)
		
		//Add it to child
		addChildNode(zAlign)
		
		//set contrainte direction to our vector
		constraints = [SCNLookAtConstraint(target: nodeDestination)]
	}
	
	override init() {
		super.init()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}


private extension SCNVector3{
	/**
	Initializes a cylinder line between two points
	
	```
	let  distance = source.distance(destination)
	```
	
	- Parameters:
		- receiver: Coordinates of the second point
	*/
	func distance(receiver:SCNVector3) -> Float{
		let xd = receiver.x - self.x
		let yd = receiver.y - self.y
		let zd = receiver.z - self.z
		let distance = Float(sqrt(xd * xd + yd * yd + zd * zd))
		
		if (distance < 0){
			return (distance * -1)
		} else {
			return (distance)
		}
	}
}

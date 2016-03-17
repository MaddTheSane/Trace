//
//  Camera.swift
//  Trace
//
//  Created by Matthew Dillard on 3/17/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

public class Camera : NSObject {
	var position = Vector3D()
	var frustrum = (near: 1.0, far: 1000.0)
	var lookDirection = Vector3D(x: 1, y: 0, z: 0)
	var upDirection = Vector3D(x: 0, y: 1, z: 0)
	
	public init(position pos:Vector3D = Vector3D(), lookDir dir:Vector3D = Vector3D(x:1,y:0,z:0), nearClip near:Double = 1.0, farClip far:Double = 1000.0, upDir up:Vector3D = Vector3D(x:0,y:1,z:0)) {
		position = pos
		lookDirection = dir
		frustrum = (near, far)
		upDirection = up
		super.init()
	}
}

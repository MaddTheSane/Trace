//
//  DirectLight.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation
import Darwin

public class DirectLight : Light {
	public var color: HDRColor
	var direction: Vector3D
	
	public init(color: HDRColor, direction: Vector3D) {
		self.color = color
		self.direction = direction.unit()
	}
	
	public func normalToLight(point: Vector3D) -> Vector3D { return -direction }
	
	public func illuminated(_: Vector3D) -> Bool { return true }
	
	public func distance(point: Vector3D) -> Double { return DBL_MAX }
}

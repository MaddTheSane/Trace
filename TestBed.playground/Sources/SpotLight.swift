//
//  SpotLight.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

public class SpotLight : Light {
	public var color: HDRColor
	var position: Vector3D
	var direction: Vector3D
	var angle: Double
	
	public init(color: HDRColor, position: Vector3D, direction: Vector3D, angle: Double) {
		self.color = color
		self.position = position
		self.direction = direction.unit()
		self.angle = angle
	}
	
	public func normalToLight(point: Vector3D) -> Vector3D { return (position - point).unit() }
	
	public func illuminated(point: Vector3D) -> Bool {
		let pointRay = (point - position).unit();
		let angleBetween = acos(direction • pointRay)  * (180.0 / M_PI);
		return angleBetween <= angle;
	}
	
	public func distance(point: Vector3D) -> Double { return (position - point).len() }
}

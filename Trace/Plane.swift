//
//  Plane.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

public class Plane : Shape {
	public var colors: ColorData
	public var position: Vector3D
	var normal: Vector3D
	let d: Double
	
	public init(colors: ColorData, position: Vector3D, normal: Vector3D) {
		self.colors = colors
		self.position = position
		self.normal = normal
		self.d = normal • position
	}
	
	public func getNormal(point: Vector3D) -> Vector3D {
		return normal
	}
	
	public func intersectRay(ray: Ray) -> Double {
		return (d - normal • ray.o) / (normal • ray.d)
	}
}

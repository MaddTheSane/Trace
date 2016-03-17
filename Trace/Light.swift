//
//  Light.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

/// Abstract class Light
public protocol Light {
	var color: CGColor { get set }
	
	func normalToLight(point: Vector3D) -> Vector3D
	
	func illuminated(point: Vector3D) -> Bool
	
	func distance(point: Vector3D) -> Double
}

public extension Light {
	public func getColor() -> CGColor { return color; }
}

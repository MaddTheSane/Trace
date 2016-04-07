//
//  PointLight.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation
import simd

public class PointLight : Light, Translatable {
	public var color: HDRColor
	public var position: Vector3D
	
	public init(color: HDRColor, position: Vector3D) {
		self.color = color
		self.position = position
	}
	
	public func normalToLight(point: Vector3D) -> Vector3D { return (position - point).unit() }
	
	public func illuminated(_: Vector3D) -> Bool { return true }
	
	public func distance(point: Vector3D) -> Double { return (position - point).length }
}

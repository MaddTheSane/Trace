//
//  Shape.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

public protocol Shape : class {
	var colors: ColorData { get set }
	var position: Vector3D { get set }
	
	func getNormal(point: Vector3D) -> Vector3D
	
	func intersectRay(ray: Ray) -> Double
}

public extension Shape {
	public func getAmbient() -> HDRColor { return colors.ambient }
	public func getDiffuse() -> HDRColor { return colors.diffuse }
	public func getOffset() -> Double { return colors.offset }
	public func getSpecular() -> HDRColor { return colors.specular }
	public func getShininess() -> Double { return colors.shininess }
	public func getGlow() -> HDRColor { return colors.glow }
	public func getPosition() -> Vector3D { return position }
}

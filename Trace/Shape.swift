//
//  Shape.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

/**
* A compound and descriptive color class that holds the following:
*
* - Ambient color
* - Diffuse color
* - Specular color
* - Shininess exponent
* - glow color
*/
public struct ColorData {
	var ambient = NSColor.blackColor()
	var diffuse = NSColor.whiteColor()
	var offset = 0.0
	var specular = NSColor.blackColor()
	var shininess = 0.0
	var glow = NSColor.blackColor()
}

public protocol Shape {
	var colors: ColorData { get set }
	var position: Vector3D { get set }
	
	func getNormal(point: Vector3D) -> Vector3D
	
	func intersectRay(origin: Vector3D, ray: Vector3D) -> Double
}

public extension Shape {
	public func getAmbient() -> NSColor { return colors.ambient }
	public func getDiffuse() -> NSColor { return colors.diffuse }
	public func getSpecular() -> NSColor { return colors.specular }
	public func getShininess() -> Double { return colors.shininess }
	public func getGlow() -> NSColor { return colors.glow }
	public func getPosition() -> Vector3D { return position }
}

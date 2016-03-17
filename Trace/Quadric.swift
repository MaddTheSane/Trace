//
//  Quadric.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

public struct Equation {
	var A = 0.0, B = 0.0, C = 0.0
	var D = 0.0, E = 0.0, F = 0.0
	var G = 0.0, H = 0.0, I = 0.0
	var J = 0.0
	
	func ABC() -> Vector3D { return Vector3D(x: A, y: B, z: C) }
	func DEF() -> Vector3D { return Vector3D(x: D, y: E, z: F) }
	func GHI() -> Vector3D { return Vector3D(x: G, y: H, z: I) }
}

public class Quadric : Shape {
	public var colors: ColorData
	public var position: Vector3D
	let equation: Equation
	
	public init(colors: ColorData, position: Vector3D, equation: Equation) {
		self.colors = colors
		self.position = position
		self.equation = equation
	}
	
	public func getNormal(point: Vector3D) -> Vector3D {
		var relative:Vector3D = point - position, normal:Vector3D = Vector3D()
		normal.x = 2 * equation.A * relative.x + equation.E * relative.z + equation.F * relative.y + equation.G
		normal.y = 2 * equation.B * relative.y + equation.D * relative.z + equation.F * relative.x + equation.H
		normal.z = 2 * equation.C * relative.z + equation.D * relative.y + equation.E * relative.x + equation.I
		return normal.unit()
	}
	
	public func intersectRay(ray: Ray) -> Double {
		// Calculate the positions of the camera and the ray relative to the quadric
		let rCam = ray.o - position;
		let rRay = ray.d;
		
		// Precalculate these values for our quadratic equation
		let V1 = rRay ⊗ rRay
		let V2 = 2 * Vector3D(x: rRay.x * rRay.y, y: rRay.y * rRay.z, z: rRay.x * rRay.z)
		let V3 = rCam ⊗ rRay
		let V4 = Vector3D(x: rRay.x * rCam.y + rCam.x * rRay.y, y: rCam.y * rRay.z + rRay.y * rCam.z, z: rCam.x * rRay.z + rRay.x * rCam.z)
		let V5 = rRay
		let V6 = rCam ⊗ rCam
		let V7 = 2 * Vector3D(x: rCam.x * rCam.y, y: rCam.y * rCam.z, z: rCam.x * rCam.z)
		let V8 = 2 * rCam;
		
		// Calculate the quadratic coefficients
		let A = equation.ABC() • V1 + equation.DEF() • V2
		let B = equation.ABC() • V3 + equation.DEF() • V4 + equation.GHI() • V5
		let C = equation.ABC() • V6 + equation.DEF() • V7 + equation.GHI() • V8 + equation.J
		
		// Calculate the root value for our quadratic formula
		var root = (B * B) - (A * C);
		
		// No collision if the root is imaginary
		if (root < 0) {
			return -1.0;
		}
		
		// Take its root if it's real
		root = sqrt(root);
		
		// Calculate both intersections
		let D1 = (-B + root)/A;
		let D2 = (-B - root)/A;
		
		// Return closest intersection
		if (D1 < D2) {
			return D1;
		}
		return D2;
	}
}

//
//  Vector3.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

/**
* A 3 dimensional vector class that supports many useful Vector operations:
*
* - Negation
* - Addition & Subtraction
* - Division & multiplication by Double
* - Dot and cross products
* - Normalization
*/
public struct Vector3D : Equatable, CustomStringConvertible {
	public var x = 0.0, y = 0.0, z = 0.0
	
	public init(_ x: Double = 0, _ y: Double = 0, _ z: Double = 0) {
		self.x = x
		self.y = y
		self.z = z
	}
	
	public var description: String {
		return String(format: "(%.3f, %.3f, %.3f)", x, y, z)
	}
	
	/// Absolute value of a Vector
	/// - Returns: √(x² + y² + z²)
	public func len() -> Double { return sqrt(x * x + y * y + z * z) }
	
	/// Normalizes a vector
	/// - Returns: unit length vector
	public func unit() -> Vector3D { return self/len() }
}

public prefix func -(v: Vector3D) -> Vector3D { return Vector3D(-v.x, -v.y, -v.z) }

public func *(lhs: Vector3D, rhs: Double) -> Vector3D { return Vector3D(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
public func *(lhs: Double, rhs: Vector3D) -> Vector3D { return Vector3D(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z) }
public func /(lhs: Vector3D, rhs: Double) -> Vector3D { return Vector3D(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs) }
public func +(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
public func -(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }

public func ==(lhs: Vector3D, rhs: Vector3D) -> Bool { return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z }
//public func !=(lhs: Vector3D, rhs: Vector3D) -> Bool { return (lhs.x != rhs.x || lhs.y != rhs.y || lhs.z != rhs.z) }

public func *=(inout lhs: Vector3D, rhs: Double) -> Vector3D { lhs.x *= rhs; lhs.y *= rhs; lhs.z *= rhs; return lhs }
public func /=(inout lhs: Vector3D, rhs: Double) -> Vector3D { lhs.x /= rhs; lhs.y /= rhs; lhs.z /= rhs; return lhs }
public func +=(inout lhs: Vector3D, rhs: Vector3D) -> Vector3D { lhs.x += rhs.x; lhs.y += rhs.y; lhs.z += rhs.z; return lhs }
public func -=(inout lhs: Vector3D, rhs: Vector3D) -> Vector3D { lhs.x -= rhs.x; lhs.y -= rhs.y; lhs.z -= rhs.z; return lhs }

infix operator • { associativity left precedence 150 }
public func •(lhs: Vector3D, rhs: Vector3D) -> Double { return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z }

infix operator ⨯ { associativity left precedence 150 }
public func ⨯(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(lhs.y * rhs.z - lhs.z * rhs.y, lhs.z * rhs.x - lhs.x * rhs.z, lhs.x * rhs.y - lhs.y * rhs.x) }

infix operator ⊗ { associativity left precedence 150 }
public func ⊗(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z) }

public struct Ray {
	var o = Vector3D(), d = Vector3D(1, 0, 0)
}

public func *(ray: Ray, dist: Double) -> Vector3D { return ray.o + dist * ray.d }

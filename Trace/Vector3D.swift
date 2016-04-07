//
//  Vector3.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation
import simd


/**
 * A 3 dimensional vector class that supports many useful Vector operations:
 * - Negation
 * - Addition & Subtraction
 * - Division & multiplication by Double
 * - Dot and cross products
 * - Normalization
 */
public typealias Vector3D = double3

extension Vector3D: Equatable {
	/// Absolute value of a Vector
	/// - Returns: √(x² + y² + z²)
	public var length: Double {
		return simd.length(self)
	}
	
	/// Normalizes a vector
	/// - Returns: unit length vector
	public func unit() -> Vector3D {
		return normalize(self)
	}
}

public prefix func -(v: Vector3D) -> Vector3D { return Vector3D(x: -v.x, y: -v.y, z: -v.z) }

public func *(lhs: Vector3D, rhs: Double) -> Vector3D {
	return Vector3D(rhs) * lhs
}
public func *(lhs: Double, rhs: Vector3D) -> Vector3D {
	return rhs * Vector3D(lhs)
}
public func /(lhs: Vector3D, rhs: Double) -> Vector3D {
	return lhs / Vector3D(rhs)
}

public func ==(lhs: Vector3D, rhs: Vector3D) -> Bool { return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z }
//public func !=(lhs: Vector3D, rhs: Vector3D) -> Bool { return (lhs.x != rhs.x || lhs.y != rhs.y || lhs.z != rhs.z) }

public func *=(inout lhs: Vector3D, rhs: Double) -> Vector3D {
	lhs *= Vector3D(rhs)
	return lhs }
public func /=(inout lhs: Vector3D, rhs: Double) -> Vector3D {
	lhs /= Vector3D(rhs)
	return lhs
}

infix operator • { associativity left precedence 150 }
public func •(lhs: Vector3D, rhs: Vector3D) -> Double { return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z }

infix operator ⨯ { associativity left precedence 150 }
public func ⨯(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(x: lhs.y * rhs.z - lhs.z * rhs.y, y: lhs.z * rhs.x - lhs.x * rhs.z, z: lhs.x * rhs.y - lhs.y * rhs.x) }

infix operator ⊗ { associativity left precedence 150 }
public func ⊗(lhs: Vector3D, rhs: Vector3D) -> Vector3D { return Vector3D(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z) }

//TODO: use double3x2?
public struct Ray {
	var o = Vector3D(), d = Vector3D(x: 1, y: 0, z: 0)
}

public func *(ray: Ray, dist: Double) -> Vector3D { return ray.o + dist * ray.d }


public protocol Translatable {
	var position: Vector3D { get set }
}

public extension Translatable {
	public mutating func translate(x: Double, _ y: Double, _ z: Double) {
		position += Vector3D(x: x, y: y, z: z)
	}
}




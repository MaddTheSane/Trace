//
//  Sphere.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Foundation

public class Sphere : Quadric {
	public init?(colors: ColorData, position: Vector3D, radius: Double) {
		super.init(colors: colors, position: position, equation: Equation(A: 1,B: 1,C: 1,D: 0,E: 0,F: 0,G: 0,H: 0,I: 0,J: -(radius * radius)))
		
		if radius <= 0 {
			return nil
		}
	}
}

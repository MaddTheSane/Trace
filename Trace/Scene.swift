//
//  Scene.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

public class Scene : NSObject, BooleanType {
	var ambient = NSColor.blackColor()
	var camera: Camera?
	var lights = [Light]()
	var shapes = [Shape]()
	
	public init(ambient: NSColor = NSColor.blackColor()) {
		self.ambient = ambient
		super.init()
	}
	
	public func addLight(newLight: Light) { lights.append(newLight) }
	public func addShape(newShape: Shape) { shapes.append(newShape) }
	
	public var boolValue: Bool {
		return camera != nil && shapes.count > 0 && (ambient != NSColor.blackColor() || lights.count > 0)
	}
}

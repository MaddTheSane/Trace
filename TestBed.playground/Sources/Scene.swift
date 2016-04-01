//
//  Scene.swift
//  Trace
//
//  Created by Matthew Dillard on 3/12/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

public class Scene : NSObject, BooleanType {
	var ambient = HDRColor.blackColor()
	var camera: Camera?
	var lights = [Light]()
	var shapes = [Shape]()
	
	public init(ambient: HDRColor = HDRColor.blackColor()) {
		self.ambient = ambient
		super.init()
	}
	
	public func addLight(newLight: Light) { lights.append(newLight) }
	public func addShape(newShape: Shape) { shapes.append(newShape) }
	
	public var boolValue: Bool {
		return camera != nil && shapes.count > 0 && (ambient != HDRColor.blackColor() || lights.count > 0)
	}
	
	public func preview() -> NSImage {
		return camera!.preview(resolution: (200,150))
	}
}

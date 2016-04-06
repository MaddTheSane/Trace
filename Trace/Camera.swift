//
//  Camera.swift
//  Trace
//
//  Created by Matthew Dillard on 3/17/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

public class cameraView : NSImageView {
	var rect = NSRect()
	var cam = Camera()
	var scene: Scene?
	
	override public init(frame frameRect: NSRect) {
		rect = frameRect
		scene = Scene(ambient: HDRColor.grayColor())
		
		scene!.addLight(DirectLight(color: HDRColor.whiteColor(), direction: Vector3D(x: 1, y: 1, z: 1)))
		
		var colors = ColorData()
		colors.diffuse = HDRColor.blueColor()
		
		scene!.addShape(Sphere(colors: colors, position: Vector3D(x: 10, y: 0, z: 0), radius: 9)!)
		//scene.addShape(Plane(colors: ColorData(), position: Vector3D(x: 20,y: 0,z: 0), normal: Vector3D(x: -1,y: 0,z: 0)))
		
		scene!.shapes[0].colors.ambient = HDRColor.grayColor()
		
		super.init(frame: frameRect)
	}

	required public init?(coder aDecoder: NSCoder) {
		rect = NSRect()
		scene = Scene(ambient: HDRColor.grayColor())
		
		scene!.addLight(DirectLight(color: HDRColor.whiteColor(), direction: Vector3D(x: 1, y: 1, z: 1)))
		
		var colors = ColorData()
		colors.diffuse = HDRColor.blueColor()
		
		scene!.addShape(Sphere(colors: colors, position: Vector3D(x: 10, y: 0, z: 0), radius: 9)!)
		//scene.addShape(Plane(colors: ColorData(), position: Vector3D(x: 20,y: 0,z: 0), normal: Vector3D(x: -1,y: 0,z: 0)))
		
		scene!.shapes[0].colors.ambient = HDRColor.grayColor()
		
		super.init(coder: aDecoder)
	}
	
	override public var image: NSImage? {
		get {
			return cam.capture(scene!, resolution: (200,200), SSAA: 1)
		}
		set {
			self.image = newValue
		}
	}
}

public class Camera : NSObject, Translatable {
	public var position: Vector3D
	var frustrum: (near: Double, far: Double)
	var lookDirection: Vector3D
	var upDirection: Vector3D
	public var FOV = 90.0
	
	public init(position pos:Vector3D = Vector3D(), lookDir dir:Vector3D = Vector3D(x:1,y:0,z:0), nearClip near:Double = 1.0, farClip far:Double = 1000.0, upDir up:Vector3D = Vector3D(x:0,y:1,z:0)) {
		position = pos
		lookDirection = dir
		frustrum = (near, far)
		upDirection = up
		super.init()
	}
	
	public func preview(scene: Scene, resolution res: (x: UInt, y: UInt)) -> NSImage {
		// calculate the screen dimensions relative to the eye vector given the FOV
		let uWidth = tan((FOV / 2.0) * (M_PI / 180.0)), vHeight = (Double(res.y) / Double(res.x)) * uWidth
		
		// calculate the coordinate frame for screenspace
		var deltaX = (lookDirection ⨯ upDirection).unit(), deltaY = (deltaX ⨯ lookDirection).unit()
		
		// compute the four corners of the screen in the global coordinate space
		let P00 = position + lookDirection - (deltaX * uWidth) - (deltaY * vHeight)
		let P10 = position + lookDirection + (deltaX * uWidth) - (deltaY * vHeight)
		let P01 = position + lookDirection - (deltaX * uWidth) + (deltaY * vHeight)
		
		// compute the average width of a pixel represented in screenspace
		deltaX = (P10 - P00) / Double(res.x)
		deltaY = (P01 - P00) / Double(res.y)
		
		return NSImage.init(named: "aweFace")!
	}
	
	public func capture(scene: Scene, resolution res: (x: UInt, y: UInt), SSAA: UInt) -> NSImage {
		// calculate the screen dimensions relative to the eye vector given the FOV
		let uWidth = tan((FOV / 2.0) * (M_PI / 180.0)), vHeight = (Double(res.y) / Double(res.x)) * uWidth
		
		// calculate the coordinate frame for screenspace
		var deltaX = (lookDirection ⨯ upDirection).unit(), deltaY = (deltaX ⨯ lookDirection).unit()
		
		// compute the four corners of the screen in the global coordinate space
		var P00 = position + lookDirection - (deltaX * uWidth) - (deltaY * vHeight)
		let P10 = position + lookDirection + (deltaX * uWidth) - (deltaY * vHeight)
		let P01 = position + lookDirection - (deltaX * uWidth) + (deltaY * vHeight)
		
		// compute the average width of a pixel represented in screenspace
		deltaX = (P10 - P00) / Double(res.x)
		deltaY = (P01 - P00) / Double(res.y)
		
		var pixels = [HDRColor]()
		//auto futurepixels = std::vector<std::future<RGBA>>();
		
		// calculate the value of each pixel
		for _ in 0..<res.y {
			var pixelPosition = P00
			for _ in 0..<res.x {
				//futurepixels.emplace_back(pool.enqueue([&, hRay]{ return castRays(hRay, ambientLight, diffuseOffset); }));
				pixels.append(getPixel(scene, GCPP: pixelPosition, SSAA: SSAA, dims: (deltaX, deltaY)))
				
				// increments
				pixelPosition += deltaX
			}
			P00 += deltaY;
		}
		
		return imageFromARGB32Bitmap(pixels, width: Int(res.x), height: Int(res.y))
	}
	
	private func getPixel(scene: Scene, GCPP: Vector3D, SSAA: UInt, dims: (width: Vector3D, height: Vector3D)) -> HDRColor {
		var pixel = HDRColor()
		var closest: Shape?
		
		// collect samples of the scene for this current pixel
		for _ in 0...SSAA {
			// randomly generate offsets for the current subsample
			let horiOffset = drand48()
			let vertOffset = drand48()
			
			// get the subsample position and construct a ray from it
			let subsample = GCPP + (dims.width * horiOffset) + (dims.height * vertOffset)
			let ray = Ray(o: position, d: (subsample - position).unit())
			
			// initialize for color sampling
			var zValue = frustrum.far
			
			// detect the closest shape
			for s in scene.shapes {
				let intersect = s.intersectRay(ray)
				if (intersect > frustrum.near && intersect < zValue) {
					zValue = intersect
					closest = s
				}
			}
			
			// retrieve the shape's color
			pixel += getColor(scene, of: closest!, at: ray * zValue, from: -ray.d)
		}
		
		// return the normalized supersampled value
		return pixel / Double(SSAA);
	}
	
	private func getColor(scene: Scene, of shape: Shape, at point: Vector3D, from: Vector3D) -> HDRColor {
		// color independant of all other lighting conditions
		let glow = shape.getGlow()
		
		// color dependant on the ambient light of the scene
		let ambient = scene.ambient * shape.getAmbient();
		
		var diffuse = HDRColor(), specular = HDRColor()
		// iterate through all lights in the scene
		for l  in scene.lights {
			let directionToLight = l.normalToLight(point)
			
			// shadow check
			if l.illuminated(point) && !obstructed(Ray(o: point, d: directionToLight), on: shape, inScene: scene, from: l) {
				let product = shape.getNormal(point) • directionToLight
				let offset = (product + shape.getOffset())/(1 + shape.getOffset())
				
				// color from direct diffuse illumination
				diffuse += (shape.getDiffuse() * l.getColor()) * max(offset, 0.0)
				
				if product > 0.0 {
					let halfway = (from + l.normalToLight(point)).unit()
					let specularvalue = shape.getNormal(point) • halfway
					
					// color from specular highlights
					specular += shape.getSpecular() * l.getColor() * pow(max(specularvalue, 0.0), shape.getShininess());
				}
			}
		}
		
		return glow + ambient + diffuse + specular
	}
	
	private func obstructed(ray: Ray, on: Shape, inScene: Scene, from: Light) -> Bool {
		// first get the distance from the surface to the light
		let distanceToLight = from.distance(ray.o);
		
		// then see if any shapes are closer than that
		for s in inScene.shapes {
			// we can ignore the original object
			if s !== on {
				let intersect = s.intersectRay(ray)
				if intersect > 0.0 && intersect < distanceToLight {
					return true;
				}
			}
		}
		
		return false
	}
}

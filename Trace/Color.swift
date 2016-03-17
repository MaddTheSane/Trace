//
//  Color.swift
//  Trace
//
//  Created by Matthew Dillard on 3/17/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

/**
* A compound and descriptive color class that holds the following:
*
* - Ambient color
* - Diffuse color
* - Diffuse offset
* - Specular color
* - Shininess exponent
* - glow color
*/
public struct ColorData {
	var ambient = HDRColor()
	var diffuse = HDRColor.whiteColor()
	var offset = 0.0
	var specular = HDRColor()
	var shininess = 0.0
	var glow = HDRColor()
}


public struct HDRColor : Equatable, CustomStringConvertible {
	var r = 0.0, g = 0.0, b = 0.0
	
	public var description: String {
		return "\(Int(r * 256) - 1)R \(Int(g * 256) - 1)G \(Int(b * 256) - 1)B"
	}
	
	static func whiteColor() -> HDRColor { return HDRColor(r: 1, g: 1, b: 1) }
	static func blackColor() -> HDRColor { return HDRColor(r: 0, g: 0, b: 0) }
	static func grayColor() -> HDRColor { return HDRColor(r: 0.5, g: 0.5, b: 0.5) }
	static func redColor() -> HDRColor { return HDRColor(r: 1, g: 0, b: 0) }
	static func greenColor() -> HDRColor { return HDRColor(r: 0, g: 1, b: 0) }
	static func blueColor() -> HDRColor { return HDRColor(r: 0, g: 0, b: 1) }
	static func yellowColor() -> HDRColor { return HDRColor(r: 1, g: 1, b: 0) }
	static func magentaColor() -> HDRColor { return HDRColor(r: 1, g: 0, b: 1) }
	static func cyanColor() -> HDRColor { return HDRColor(r: 0, g: 1, b: 1) }
}

public func *(lhs: Double, rhs: HDRColor) -> HDRColor { return HDRColor(r: lhs * rhs.r, g: lhs * rhs.g, b: lhs * rhs.g) }
public func *(lhs: HDRColor, rhs: Double) -> HDRColor { return HDRColor(r: lhs.r * rhs, g: lhs.g * rhs, b: lhs.g * rhs) }
public func /(lhs: HDRColor, rhs: Double) -> HDRColor { return HDRColor(r: lhs.r / rhs, g: lhs.g / rhs, b: lhs.g / rhs) }
public func *(lhs: HDRColor, rhs: HDRColor) -> HDRColor { return HDRColor(r: lhs.r * rhs.r, g: lhs.g * rhs.g, b: lhs.b * rhs.b) }
public func +(lhs: HDRColor, rhs: HDRColor) -> HDRColor { return HDRColor(r: lhs.r + rhs.r, g: lhs.g + rhs.g, b: lhs.b + rhs.b) }

public func *=(inout lhs: HDRColor, rhs: Double) -> HDRColor { lhs.r *= rhs; lhs.g *= rhs; lhs.b *= rhs; return lhs }
public func *=(inout lhs: HDRColor, rhs: HDRColor) -> HDRColor { lhs.r *= rhs.r; lhs.g *= rhs.g; lhs.b *= rhs.b; return lhs }
public func +=(inout lhs: HDRColor, rhs: HDRColor) -> HDRColor { lhs.r += rhs.r; lhs.g += rhs.g; lhs.b += rhs.b; return lhs }

public func ==(lhs: HDRColor, rhs: HDRColor) -> Bool { return lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b }


public func imageFromARGB32Bitmap(pixels:[HDRColor], width:Int, height:Int) -> NSImage {
	let bitsPerComponent = 8
	let bitsPerPixel = 32
	
	assert(pixels.count == Int(width * height))
	
	struct argb {
		var a:UInt8 = 0, r:UInt8 = 0, g:UInt8 = 0, b:UInt8 = 0
	}
	
	var data = pixels.map {
		(let color) -> argb in
		let alpha = UInt8(255)
		let red = UInt8(max(min(color.r * 256 - 1, 255), 0))
		let green = UInt8(max(min(color.g * 256 - 1, 255), 0))
		let blue = UInt8(max(min(color.b * 256 - 1, 255), 0))
		
		return argb(a: alpha, r: red, g: green, b: blue)
	}
	
	let providerRef = CGDataProviderCreateWithCFData(
		NSData(bytes: &data, length: data.count * sizeof(argb))
	)
	
	let cgim = CGImageCreate(
		width,
		height,
		bitsPerComponent,
		bitsPerPixel,
		width * sizeof(argb),
		CGColorSpaceCreateDeviceRGB(),
		CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue),
		providerRef,
		nil,
		true,
		CGColorRenderingIntent.RenderingIntentDefault
	)
	return NSImage(CGImage: cgim!, size: NSZeroSize)
}

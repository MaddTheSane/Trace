//
//  TraceTests.swift
//  TraceTests
//
//  Created by Matthew Dillard on 3/17/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import XCTest
@testable import Trace

class TraceTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
		
		let test = Vector3D()
		
		print(test)
	}

	func testPerformanceExample() {
		// This is an example of a performance test case.
		let testScene = Scene(ambient: HDRColor.grayColor())
		
		testScene.addLight(DirectLight(color: HDRColor.blueColor(), direction: Vector3D(x: 0, y: 0, z: -1)))
		
		var colors = ColorData()
		colors.diffuse = HDRColor.blueColor()
		
		testScene.addShape(Sphere(colors: colors, position: Vector3D(x: 10, y: 0, z: 0), radius: 2)!)
		testScene.addShape(Plane(colors: ColorData(), position: Vector3D(x: 20,y: 0,z: 0), normal: Vector3D(x: -1,y: 0,z: 0)))
		
		let testCamera = Camera()
		
		self.measureBlock {
			_ = testCamera.capture(testScene, resolution: (200,200), SSAA: 1)
		}
	}
}

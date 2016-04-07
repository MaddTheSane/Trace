//
//  MasterViewController.swift
//  Trace
//
//  Created by Matthew Dillard on 4/6/16.
//  Copyright © 2016 Matthew Dillard. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
	var scene = Scene(ambient: HDRColor.grayColor())
	var camera = Camera()
	@IBOutlet weak var ImageView: NSImageView!
	
	required init?(coder: NSCoder) {
		scene.addLight(DirectLight(color: HDRColor.whiteColor(), direction: Vector3D(x: 1, y: 1, z: 1)))
		
		var colors = ColorData()
		colors.diffuse = HDRColor.blueColor()
		
		scene.addShape(Sphere(colors: colors, position: Vector3D(x: 10, y: 0, z: 0), radius: 9)!)
		//scene.addShape(Plane(colors: ColorData(), position: Vector3D(x: 20,y: 0,z: 0), normal: Vector3D(x: -1,y: 0,z: 0)))
		
		scene.shapes[0].colors.ambient = HDRColor.grayColor()
		
		super.init(coder: coder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let rect = ImageView.bounds
		ImageView.image = camera.capture(scene, resolution: (x: UInt(rect.width), y: UInt(rect.height)), SSAA: 4)
	}
}

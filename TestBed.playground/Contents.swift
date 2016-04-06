//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

//let testScene = Scene(ambient: HDRColor.blackColor())
//
//testScene.addLight(DirectLight(color: HDRColor.grayColor(), direction: Vector3D(1, 1, 1)))
//
//testScene.addShape(Sphere(colors: ColorData.blueColors(), position: Vector3D(10,0,0), radius: 9)!)
//testScene.addShape(Plane(colors: ColorData.whiteColors(), position: Vector3D(20,0,0), normal: Vector3D(-1,0,0)))
//
//let testCamera = Camera()
//
//var picture = testCamera.capture(testScene, resolution: (200,200), SSAA: 1)


let p00 = Vector3D(3.000,19.000,9.000)
let n0 = Vector3D(0.000,0.707,-0.707)
let n1 = Vector3D(0.943,-0.236,-0.236)

let n2 = Vector3D(0.333,0.667,0.667)

let s0 = 19.0
let s1 = 22.0

let p10 = p00 + s0 * n0
let p01 = p00 + s1 * n1
let p11 = p00 + s0 * n0 + s1 * n1

let M = 13.0, N = 15.0
let m = 5.0, n = 2.0
let r0 = 0.49, r1 = 0.67

var pL = p00 + ((m + r0) / M) * s0 * n0 + ((n + r1) / N) * s1 * n1

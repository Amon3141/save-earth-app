//
//  EarthView.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-11-13.
//

import SwiftUI
import SceneKit

struct EarthView: UIViewRepresentable {
    
    var phase: Int
    
    func makeUIView(context: Context) -> SCNView {
        
        let sceneView = SCNView()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        // Create a new scene
        let scene = SCNScene()
        
        //creating a camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        scene.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 2)
        scene.rootNode.addChildNode(lightNode)
        
        let earthNode = getEarthNode(phase: phase)
        
        scene.rootNode.addChildNode(earthNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.backgroundColor = UIColor.black
        sceneView.allowsCameraControl = true
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    private func getEarthNode(phase: Int) -> SCNNode {
        var earthNode: SCNNode = SCNNode()
        
        if phase == 0 {
            earthNode = EarthNode0()
        } else if phase == 1 {
            earthNode = EarthNode1()
        } else if phase == 2 {
            earthNode = EarthNode2()
        } else if phase == 3 {
            earthNode = EarthNode3()
        } else if phase == 4 {
            earthNode = EarthNode4()
        } else if phase == 5 {
            earthNode = EarthNode5()
        } else if phase == 6 {
            earthNode = EarthNode6()
        } else if phase == 7 {
            earthNode = EarthNode7()
        } else if phase == 8 {
            earthNode = EarthNode8()
        } else if phase == 9 {
            earthNode = EarthNode9()
        } else if phase == 10 {
            earthNode = EarthNode10()
        } else if phase == 11 {
            earthNode = EarthNode11()
        } else if phase == 12 {
            earthNode = EarthNode12()
        } else if phase == 13 {
            earthNode = EarthNode13()
        } else if phase == 14 {
            earthNode = EarthNode14()
        } else if phase == 15 {
            earthNode = EarthNode15()
        }
        
        return earthNode
    }
}

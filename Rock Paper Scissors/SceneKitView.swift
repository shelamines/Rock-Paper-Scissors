//
//  SceneKitView.swift
//  Rock Paper Scissors
//
//  Created by Shelamines Julianni on 23/05/23.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    
    var modelName: String
    
    func makeUIView(context: Context) -> SCNView {
        // Create an SCNView instance to display the SceneKit content
        let sceneView = SCNView()
        sceneView.autoenablesDefaultLighting = true
        
        // Set up the scene and add it to the SCNView
        let scene = SCNScene()
        sceneView.scene = scene
        
        // Configure the scene view properties as desired
        sceneView.backgroundColor = UIColor.white
        
        // Load and add your USDZ model to the scene
        if let modelURL = Bundle.main.url(forResource: modelName, withExtension: "usdz"){
            
            let modelNode = SCNReferenceNode(url: modelURL)
            
            scene.rootNode.addChildNode(modelNode!)
            modelNode?.load()
            
        }
        
        return sceneView
    }

    
    func updateUIView(_ uiView: SCNView, context: Context) {
        // Update the view if needed
    }
}




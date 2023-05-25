//
//  SceneKitAssets.swift
//  Rock Paper Scissors
//
//  Created by Shelamines Julianni on 23/05/23.
//

import Foundation
import SceneKit

class SceneKitAssets {
    static func loadModel(named modelName: String) -> SCNNode? {
        guard let sceneURL = Bundle.main.url(forResource: modelName, withExtension: "usdz") else {
            print("Failed to find the model file: \(modelName).usdz")
            return nil
        }
        
        let sceneSource = SCNSceneSource(url: sceneURL, options: nil)
        let rootNode = sceneSource?.entryWithIdentifier("USDZContainer", withClass: SCNNode.self)
        
        return rootNode
    }
    
    static func loadAsset(for objectName: String) -> SCNNode? {
        // Here, you can define your mappings of object names to model names
        let objectToModelMapping: [String: String] = [
            "rock": "RockModel",
            "paper": "Paper",
            "scissors": "Scissors-2"
        ]
        
        guard let modelName = objectToModelMapping[objectName] else {
            print("No model mapping found for object: \(objectName)")
            return nil
        }
        
        return loadModel(named: modelName)
    }
}


//
//  Winning Condition.swift
//  Rock Paper Scissors
//
//  Created by Shelamines Julianni on 22/05/23.
//

import Foundation

class WinningConditions: Identifiable {
    var id = UUID()
    let result: GameResult
    let left: SceneKitView
    let right: SceneKitView
    
    init(result: GameResult, left: SceneKitView, right: SceneKitView) {
        self.id = UUID()
        self.result = result
        self.left = left
        self.right = right
    }
}

struct winningConditionsLists {
    static let lists: [WinningConditions] = [
        WinningConditions(
            result: .leftWins,
            left: SceneKitView(modelName: "RockModel"),
            right: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .leftWins,
            left: SceneKitView(modelName: "Scissors-2"),
            right: SceneKitView(modelName: "Paper")
        ),
        WinningConditions(
            result: .leftWins,
            left: SceneKitView(modelName: "Paper"),
            right: SceneKitView(modelName: "RockModel")
        ),
        WinningConditions(
            result: .rightWins,
            left: SceneKitView(modelName: "Scissors-2"),
            right: SceneKitView(modelName: "RockModel")
        ),
        WinningConditions(
            result: .rightWins,
            left: SceneKitView(modelName: "RockModel"),
            right: SceneKitView(modelName: "Paper")
        ),
        WinningConditions(
            result: .rightWins,
            left: SceneKitView(modelName: "Paper"),
            right: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .draw,
            left: SceneKitView(modelName: "RockModel"),
            right: SceneKitView(modelName: "RockModel")
        ),
        WinningConditions(
            result: .draw,
            left: SceneKitView(modelName: "Scissors-2"),
            right: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .draw,
            left: SceneKitView(modelName: "Paper"),
            right: SceneKitView(modelName: "Paper")
        )
    ]
    
}

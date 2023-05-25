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
    let object1: SceneKitView
    let object2: SceneKitView
    
    init(result: GameResult, object1: SceneKitView, object2: SceneKitView) {
        self.id = UUID()
        self.result = result
        self.object1 = object1
        self.object2 = object2
    }
}

struct winningConditionsLists {
    static let lists: [WinningConditions] = [
        WinningConditions(
            result: .leftWins,
            object1: SceneKitView(modelName: "RockModel"),
            object2: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .leftWins,
            object1: SceneKitView(modelName: "Scissors-2"),
            object2: SceneKitView(modelName: "Paper")
        ),
        WinningConditions(
            result: .leftWins,
            object1: SceneKitView(modelName: "Paper"),
            object2: SceneKitView(modelName: "RockModel")
        ),
        WinningConditions(
            result: .rightWins,
            object1: SceneKitView(modelName: "RockModel"),
            object2: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .rightWins,
            object1: SceneKitView(modelName: "RockModel"),
            object2: SceneKitView(modelName: "Paper")
        ),
        WinningConditions(
            result: .rightWins,
            object1: SceneKitView(modelName: "Scissors-2"),
            object2: SceneKitView(modelName: "Paper")
        ),
        WinningConditions(
            result: .draw,
            object1: SceneKitView(modelName: "RockModel"),
            object2: SceneKitView(modelName: "RockModel")
        ),
        WinningConditions(
            result: .draw,
            object1: SceneKitView(modelName: "Scissors-2"),
            object2: SceneKitView(modelName: "Scissors-2")
        ),
        WinningConditions(
            result: .draw,
            object1: SceneKitView(modelName: "Paper"),
            object2: SceneKitView(modelName: "Paper")
        )
    ]
    
}

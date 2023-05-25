//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Shelamines Julianni on 19/05/23.
//

import SwiftUI
import SceneKit

enum GameResult: String, CaseIterable {
    case leftWins = "Left Wins"
    case rightWins = "Right Wins"
    case draw = "Draw"
}

struct ContentView: View {
    @State private var result: String = ""
    @State private var timerValue = 0
    @State var score = 0
    @State var round = 0
    @State var winner: GameResult = .draw
    @State var isShow: Bool = false
    let sceneView = SCNView()
    let timer = Timer.publish(every: 0.01, on: .main, in: .common)
    
    @State var winningCondition: WinningConditions? = nil
    @State var randomSign: GameResult?
    
    var body: some View {
        ZStack {
            if !isShow {
                VStack {
                    Group {
                        HStack {
                            Text("\(formatTime(timerValue)) ms")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .padding(10)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 20)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Text("\(score) pt")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .padding(10)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.top, 20)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            //                    Text(winningCondition?.object2 ?? "")
                        }
                        Spacer()
                        
                        HStack {
                            self.winningCondition?.object1
                            self.winningCondition?.object2
                        }
                        
                        //                    SceneKitView(modelName: "RockModel")
                        //                        .frame(width: 200, height: 350)
                        //
                        //                    SceneKitView(modelName: "Scissors")
                        //                        .frame(width: 200, height: 350)
                        //                }
                        
                        Spacer().frame(width: 50)
                    }
                    
                    
                    HStack {
                        Spacer()
                        
                        CustomButton(action: {
                            handleResultButtonPressed(userSelection: .leftWins)
                        }, label: "Left Wins", color: .red, padding: EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                        
                        Spacer()
                        
                        CustomButton(action: {
                            handleResultButtonPressed(userSelection: .draw)
                        }, label: "Draw", color: .yellow, padding: EdgeInsets(top: 30, leading: 16, bottom: 30, trailing: 16))
                        
                        Spacer()
                        
                        CustomButton(action: {
                            handleResultButtonPressed(userSelection: .rightWins)
                        }, label: "Right Wins", color: .blue, padding: EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                        
                        Spacer()
                    }
                }
            }
            
            scoreView(score: score)
        }
        .onReceive(timer) { _ in
            timerValue += 1
        }
        .onAppear {
            winner = randomResult()
        }
        .onAppear {
            startGame()
        }
    }
    
    func formatTime(_ milliseconds: Int) -> String {
        return "\(milliseconds)"
    }
    
    func randomResult() -> GameResult{
        let allResult = GameResult.allCases
        let randomSign = allResult.randomElement()!
        //        animasi tangan siapa yang menang
        self.randomSign = randomSign
        gettingAsset()
        print("random")
//        timer.connect().cancel()
        timerValue = 0
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//
//            timer.connect()
//        }
        return randomSign
    }
    
    func handleResultButtonPressed(userSelection: GameResult) {
        let gameResult = winner
        //        let gameResult = simulateHandAnimations()
        // score calculation
        if round >= 10 {
                // Game has finished
                finishGame()
            } else {
                // Continue to the next round
                round += 1
                winner = randomResult()
                timerValue = 0
            }
        if gameResult == userSelection {
            print("You won")
        } else {
            print("You lost")
        }
        switch (userSelection, gameResult) {
        case (.leftWins, .leftWins), (.rightWins, .rightWins), (.draw, .draw):
            if timerValue <= 300 {
                score += 4
            } else {
                score += 1
            }
        default:
            score -= 3
        }
        
        timerValue = 0
        winner = randomResult()
        
        isShow = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.isShow = false
            gettingAsset()
        }
        
    }
//    func randomResult2() -> String {
//        let shuffledChoices = winningConditions.keys.shuffled()
//        let randomChoice = shuffledChoices[0]
//        return assetMapping[randomChoice] ?? ""
//    }
   
    func gettingAsset() {
        var chosenWinningCondition: [WinningConditions] = []
        for winningCondition in winningConditionsLists.lists {
            if winningCondition.result == self.randomSign {
                chosenWinningCondition.append(winningCondition)
            }
        }
        chosenWinningCondition.shuffle()
        self.winningCondition = chosenWinningCondition.first
    }
    
    func startGame() {
        round = 1
        winner = randomResult()
        timerValue = 0
    }
    func finishGame() {
        // Display game over message or perform any necessary actions
        print("Game over!")
    }
    
    @ViewBuilder
    func CustomButton(action: @escaping () -> Void, label: String, color: Color, padding: EdgeInsets) -> some View {
        Button(action: action) {
            Text(label)
                .font(.largeTitle)
                .bold()
                .padding(padding)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(7)
        }
    }
    
    @main
    struct RockPaperScissorsApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
}

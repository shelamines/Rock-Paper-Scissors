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
    @State var isFinished : Bool = false
    @State private var result: String = ""
    @State private var timerValue = 0
    @State var score = 0
    @State var round = 0
    @State var lastMS = 0
    @State var winner: GameResult = .draw
    @State var isShow: Bool = false
    @State var point : String = "+1"
    let sceneView = SCNView()
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    
    @State var winningCondition: WinningConditions? = nil
    @State var randomSign: GameResult?
    
    var body: some View {
        if isFinished {
            scoreView(score: $score, isFinished: $isFinished)
        } else {
            ZStack {
                if !isShow {
                    VStack {
                        Group {
                            HStack {
                                Text("\(formatTime(timerValue))ms")
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
                            }
                            Spacer()
                            
                            HStack {
                                self.winningCondition?.object1
                                self.winningCondition?.object2
                            }
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
                } else {
                    ZStack {
                        Color.white // Background color of the VStack
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            
                            HStack{
                                Text("\(formatTime(lastMS))ms")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .padding(10)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.top, 20)
                                    .padding(.leading, 20)
                                Text(point)
                                Spacer()
                            }
                            Spacer()
                        }
                        //                .frame(height: 50)
                        .padding(.top, 20)
                        .padding(.leading, 16)
                    }
                }
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
            .background((!isShow) ? .white : .black)
        }
    }
    
    func formatTime(_ milliseconds: Int) -> String {
        return "\(milliseconds)"
    }
    
    func randomResult() -> GameResult{
        let allResult = GameResult.allCases
        let randomSign = allResult.randomElement()!
        self.randomSign = randomSign
        gettingAsset()
        //        timer.connect().cancel()
        //        timerValue = 0
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
            lastMS = timerValue
//            timerValue = 0
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
                point = "+4"
             
            } else {
                score += 1
                point = "+1"
               
            }
        default:
            score -= 3
            point = "-3"
          
        }
        
        timerValue = 0
        winner = randomResult()
        
        isShow = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.isShow = false
            gettingAsset()
            timerValue = 0
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
        isFinished = true
        timerValue = 0
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

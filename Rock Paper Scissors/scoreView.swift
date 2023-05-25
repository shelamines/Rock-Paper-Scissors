//
//  scoreView.swift
//  Rock Paper Scissors
//
//  Created by Shelamines Julianni on 24/05/23.
//

import SwiftUI

struct scoreView: View {
    @Binding var score: Int
    @Binding var isFinished : Bool
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.largeTitle)
                .padding()
            
            Text("Grade: \(grade(for: score))")
                .font(.title)
            
            Button {
                score = 0
                isFinished = false
            } label: {
                Text("Play Again")
            }

        }
    }
    
    func grade(for score: Int) -> String {
        switch score {
        case 30...Int.max:
            return "S"
        case 27...29:
            return "A"
        case 24...26:
            return "B"
        case 21...23:
            return "C"
        case 18...20:
            return "D"
        case 15...17:
            return "E"
        default:
            return "F"
        }
    }

//    struct scoreView_Previews: PreviewProvider {
//        static var previews: some View {
//            scoreView(score: Int)
//        }
//    }
}

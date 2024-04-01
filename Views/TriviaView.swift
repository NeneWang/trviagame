//
//  TriviaView.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        if triviaManager.reachedEnd{
            VStack(spacing: 20){
                Text("Trivia Game").title()
                Text("Congratulations, you completed the game!")
                Text("You Scored \(triviaManager.score) out of \(triviaManager.length)")

                Button{
                    Task.init{
                        await triviaManager.fetchTrivia()
                    }
                }
                label: {
                    PrimaryButton(text: "Play Again" )
                }
            }
        }else{
            QuestionView().environmentObject(triviaManager)
        }
        
    }
}

#Preview {
    TriviaView().environmentObject(TriviaManager())
}

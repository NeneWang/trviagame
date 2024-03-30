//
//  QuestionView.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation
import SwiftUI

struct QuestionView: View{
    
    @EnvironmentObject var triviaManager: TriviaManager
    var body: some View {
        VStack(spacing: 40){
            HStack{
                Text("Trivia Game").title()
                Spacer()
                Text("1 out of 10")
            }
            
            ProgressBar(progress: 40)
            VStack(alignment: .leading, spacing: 20, content: {
                Text("Lake Titicaca is located between which two nations?")
                AnswerRow(answer: Answer(text: "False", isCorrect: true))
                AnswerRow(answer: Answer(text: "True", isCorrect: false))
            })
        }.padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        
        PrimaryButton(text: "Next")
    }
}



#Preview {
    QuestionView()
        .environmentObject(TriviaManager())
}

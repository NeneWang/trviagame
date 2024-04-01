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
                Text("\(triviaManager.index + 1) out of \(triviaManager.length)")
            }
            
            ProgressBar(progress: triviaManager.progress)
            
                       VStack(alignment: .leading, spacing: 20) {
                           Text(triviaManager.question)
                               .font(.system(size: 20))
                               .bold()
                               .foregroundColor(.gray)
                           
                           ForEach(triviaManager.answerChoices, id: \.id) { answer in
                               AnswerRow(answer: answer)
                                   .environmentObject(triviaManager)
                           }
                       }
        }.padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        
        
        
        Button {
            triviaManager.goToNextQuestion()
        } label: {
            PrimaryButton(text: "Next", accent: triviaManager.answerSelected ? .accent : .gray)
        }
        .disabled(!triviaManager.answerSelected)
        
        
        Spacer()
    }
}



#Preview {
    QuestionView()
        .environmentObject(TriviaManager())
}

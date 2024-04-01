//
//  AnswerRow.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import SwiftUI

struct AnswerRow: View {
    var answer: Answer
    @State private var isSelected = false
    @EnvironmentObject var triviaManager: TriviaManager
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "circle.fill")
                .foregroundColor(Color("AccentColor"))
            Text(answer.text)
            if isSelected{
                Spacer()
                Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill").foregroundColor(answer.isCorrect ? .green : .red)
            }
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: triviaManager.answerSelected ? answer.isCorrect ? .green : .red : .gray , radius: 5, x: 0.5, y: 0.5)
        .onTapGesture{
            if !triviaManager.answerSelected{
                isSelected = true
                triviaManager.selectAnswer(answer: answer)
            }
            isSelected = true
        }
    }
}

#Preview {
    AnswerRow(answer: Answer(
        text: "Single",
        isCorrect: false
    )).environmentObject(TriviaManager())
}

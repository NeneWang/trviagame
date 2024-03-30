//
//  TriviaManager.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject{
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var score = 0
    @Published private(set) var reachEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var progress: CGFloat = 0.00
    @Published private(set) var answerChoices: [Answer] = []
    
    
    
    init(){
        Task.init{
            await fetchTrivia()
        }
    }
    
    func fetchTrivia() async {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {
            fatalError("Missing URL")
        }
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching data")}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)
            
            DispatchQueue.main.async{
                self.trivia = decodedData.results
                self.length = self.trivia.count
            }
        }catch{
            print("Error Fetching trivia: \(error)")
        }
    }
    
    func goToNextQuestion(){
        if index + 1 < length{
            index += 1
        } else {
            reachEnd = true
        }
    }
    
    func setQuestion(){
        answerSelected = false
        progress = CGFloat(Double((index + 1) / length) * 360)
        
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    func selectAnswer(answer: Answer){
        answerSelected = true
        if answer.isCorrect{
            score += 1
        }
    }
    
    
    
    
}



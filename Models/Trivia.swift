//
//  Trivia.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation

struct Trivia: Decodable{
    
    let responseCode: Int
    var results: [Result]
    
    struct Result: Decodable, Identifiable{
        var id: UUID {
            UUID()
        }
//        var category: String
//        var type: String
//        var difficulty: String
//        var question: String
//        var correctAnswer: String
//        var incorrectAnswer: [String]
        
        let type: String
        let difficulty: String
        let category: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
        
        var formattedQuestion: AttributedString{
            do{
                return try AttributedString(markdown: question)
            } catch{
                print("Errpr setting formattedQuestion: \(error)")
                return ""
            }
        }
        
        var answers: [Answer]{
            do{
                let correct = [
                Answer(
                    text: try AttributedString(markdown: correctAnswer), isCorrect: true)
                ]
                let incorrects = try incorrectAnswers.map{
                    answer in Answer(
                        text: try AttributedString(markdown: answer), isCorrect: false)
                    
                }
                
                let allAnswers = correct + incorrects
                return allAnswers.shuffled()
            }
            catch{
                print("error setting asnwers: \(error)")
                return []
            }
        }
        
    }
}



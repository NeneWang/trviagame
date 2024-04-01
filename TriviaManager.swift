//
//  TriviaManager.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation
import SwiftUI

class TriviaManager: ObservableObject{
    // Variables to set trivia and length of trivia
    private(set) var trivia: [Trivia.Result] = []
    @Published private(set) var length = 0
    
    // Variables to set question and answers
    @Published private(set) var index = 0
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    
    // Variables for score and progress
    @Published private(set) var score = 0
    @Published private(set) var progress: CGFloat = 0.00
    
    // Variables to know if an answer has been selected and reached the end of trivia
    @Published private(set) var answerSelected = false
    @Published private(set) var reachedEnd = false
    
    
    
    // Call the fetchTrivia function on intialize of the class, asynchronously
    init() {
        Task.init {
            await fetchTrivia()
        }
    }
    
    // Asynchronous HTTP request to get the trivia questions and answers
    func fetchTrivia(numberOfQuestions: Int = 10, category: String = "General Knowledge", difficulty: String = "easy", type: String = "multiple") async {
            // Mapping category names to their respective IDs as per the Open Trivia Database
            let categoryMapping = ["General Knowledge": 9, "Entertainment: Books": 10, "Entertainment: Film": 11, "Entertainment: Music": 12, "Entertainment: Musicals & Theatres": 13, "Entertainment: Television": 14, "Entertainment: Video Games": 15, "Entertainment: Board Games": 16, "Science & Nature": 17, "Science: Computers": 18, "Science: Mathematics": 19, "Mythology": 20, "Sports": 21, "Geography": 22, "History": 23, "Politics": 24, "Art": 25, "Celebrities": 26, "Animals": 27, "Vehicles": 28, "Entertainment: Comics": 29, "Science: Gadgets": 30, "Entertainment: Japanese Anime & Manga": 31, "Entertainment: Cartoon & Animations": 32]
            
            // Convert category string to ID
            let categoryID = categoryMapping[category] ?? 9 // Default to General Knowledge if no match
            
            // Map the type parameter to API's expected values
            let typeMapping = ["Multiple Choice": "multiple", "True / False": "boolean"]
            let apiType = typeMapping[type] ?? "multiple"
            
            // Construct the URL with custom parameters
            guard let url = URL(string: "https://opentdb.com/api.php?amount=\(numberOfQuestions)&category=\(categoryID)&difficulty=\(difficulty.lowercased())&type=\(apiType)") else {
                fatalError("Invalid URL")
            }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }

            let decoder = JSONDecoder()
            // Line below allows us to convert the correct_answer key from the API into the correctAnswer in our Trivia model, without running into an error from the JSONDecoder that it couldn't find a matching codingKey
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(Trivia.self, from: data)

            DispatchQueue.main.async {
                // Reset variables before assigning new values, for when the user plays the game another time
                self.index = 0
                self.score = 0
                self.progress = 0.00
                self.reachedEnd = false

                // Set new values for all variables
                self.trivia = decodedData.results
                self.length = self.trivia.count
                self.setQuestion()
            }
        } catch {
            print("Error fetching trivia: \(error)")
        }
    }
    
    // Function to go to next question. If reached end of the trivia, set reachedEnd to true
    func goToNextQuestion() {
        // If didn't reach end of array, increment index and set next question
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            // If reached end of array, set reachedEnd to true
            reachedEnd = true
        }
    }
    
    // Function to set a new question and answer choices, and update the progress
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double((index + 1)) / Double(length) * 350)

        // Only setting next question if index is smaller than the trivia's length
        if index < length {
            let currentTriviaQuestion = trivia[index]
            question = currentTriviaQuestion.formattedQuestion
            answerChoices = currentTriviaQuestion.answers
        }
    }
    
    // Function to know that user selected an answer, and update the score
    func selectAnswer(answer: Answer) {
        answerSelected = true
        
        // If answer is correct, increment score
        if answer.isCorrect {
            score += 1
        }
    }
    
    
}




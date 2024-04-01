//
//  ContentView.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var triviaManager = TriviaManager()

    // State variables for user selections
    @State private var numberOfQuestions = 3
    @State private var selectedCategory = "General Knowledge"
    @State private var selectedDifficulty = "Easy"
    @State private var selectedType = "Multiple Choice"

    // Options for the pickers
    private let questionNumbers = Array(3...10)
    private let categories = ["Art", "Sports", "General Knowledge"]
    private let difficulties = ["Easy", "Medium", "Hard"]
    private let types = ["Multiple Choice", "True / False"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Settings")) {
                    Picker("Number of Questions", selection: $numberOfQuestions) {
                        ForEach(questionNumbers, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty)
                        }
                    }
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }
                }

                // You cannot execute async actions directly in a NavigationLink's label.
                // Consider fetching the trivia in the TriviaView's onAppear or using a Button to initiate fetching.
                Button("Set") {
                    Task {
                        await triviaManager.fetchTrivia(numberOfQuestions: numberOfQuestions,
                                                         category: selectedCategory,
                                                         difficulty: selectedDifficulty,
                                                         type: selectedType)
                    }
                }
                
                NavigationLink{
                    TriviaView()
                        .environmentObject(triviaManager)
                }label: {
                    PrimaryButton(text: "Play")
                }
            }
            .navigationTitle("Trivia Settings")
        }
        .onAppear {
            // Ensures the navigation bar does not hide any part of the form on smaller devices
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
        }
    }
}



#Preview {
    ContentView().environmentObject(TriviaManager())
}

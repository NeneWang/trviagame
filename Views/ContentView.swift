//
//  ContentView.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var triviaManager = TriviaManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                
                VStack(spacing: 20){
                    Text("Trivia Game").title()
                    Text("Test your Skills against the world")
                }
                NavigationLink{
                    TriviaView()
                }label: {
                    PrimaryButton(text: "Play")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView().environmentObject(TriviaManager())
}

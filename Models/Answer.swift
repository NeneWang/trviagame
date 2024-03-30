//
//  Answer.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation

struct Answer: Identifiable{
    var id = UUID()
    var text: AttributedString
    var isCorrect: Bool
}


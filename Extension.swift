//
//  Extension.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import Foundation
import SwiftUI


extension Text{
    func accentTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
    
    func title() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
    }
}




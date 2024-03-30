//
//  PrimaryButton.swift
//  trviagame
//
//  Created by Nene Wang  on 3/30/24.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var accent: Color = Color("AccentColor")
    var body: some View {
        Text(text).foregroundColor(accent)
            .padding()
            .padding(.horizontal)
            .background(.black)
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}

struct primaryButton_Previews: PreviewProvider{
    
    
    static var previews: some View{
        PrimaryButton(text: "Next")
    }
}

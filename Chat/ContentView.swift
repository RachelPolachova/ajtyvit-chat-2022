//
//  ContentView.swift
//  Chat
//
//  Created by Rachel Polachova on 02/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         
        HStack(alignment: .top) {
            Image(systemName: "globe.europe.africa")
                .imageScale(.large)
                .foregroundColor(.red)
            Text("Hello, world!")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

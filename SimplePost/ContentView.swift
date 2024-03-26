//
//  ContentView.swift
//  SimplePost
//
//  Created by 신승훈 on 2024/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let content: String
}

extension Post {
    static var list: [Post] = [
        Post(username: "1", content: "1"),
        Post(username: "2", content: "2"),
        Post(username: "3", content: "3"),
        Post(username: "4", content: "4"),
        Post(username: "5", content: "5"),
        Post(username: "6", content: "6"),
    ]
}

#Preview {
    ContentView()
}

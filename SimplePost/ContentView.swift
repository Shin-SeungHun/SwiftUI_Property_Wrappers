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

/// PostRow가 선택되면 이동할 NavigationView
struct PostDetail: View {
    let post: Post
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
            Text(post.content)
                .font(.largeTitle)
            
            Button(action: {
                
            }, label: {
                Image(systemName: "pencil")
                Text("수정")
            })
        }
    }
}

/// Item view
struct PostRow: View {
    let post: Post
    let colors: [Color] = [
        Color.orange, Color.green, Color.purple, Color.pink, Color.blue, Color.yellow, Color.brown, Color.cyan, Color.mint, Color.indigo, Color.teal
    ]
    var body: some View {
        HStack {
            Circle()
                .fill(colors.randomElement() ?? .brown)
                .frame(width: 30)
            VStack(alignment: .leading) {
                Text(post.username)
                Text(post.content)
                    .font(.title)
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
        }
        .padding()
    }
}

/// model
struct Post: Identifiable {
    let id = UUID()
    let username: String
    let content: String
}

// mock
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
//    ContentView()
//    PostRow(post: Post(username: "스티브", content: "안녕하세요"))
    PostDetail(post: Post(username: "스티브", content: "안녕하세요"))
}

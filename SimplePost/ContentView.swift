//
//  ContentView.swift
//  SimplePost
//
//  Created by 신승훈 on 2024/03/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            TabView {
                Forum()
                    .tabItem {
                        Image(systemName: "bubble.right")
                    }
                Text("두번째 탭")
                    .tabItem {
                        Image(systemName: "house")
                    }
            }
            .navigationTitle("Scrum 스터디 방")
        }
    }
}

/// 지금까지 작성한 view들을 모두 가지는 view
struct Forum: View {
    @State private var list: [Post] = Post.list
    @State private var showAddView: Bool = false
    @State private var newPost = Post(username: "유저 이름", content: "")
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($list) { $post in
                    NavigationLink {
                        PostDetail(post: $post)
                    } label: {
                        PostRow(post: post)
                    }
                    .tint(.primary)
                }
            }
        }
        .refreshable {}
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            Button {
                showAddView = true
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .padding()
                    .background(Circle().fill(.white).shadow(radius: 4))
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showAddView) {
            NavigationView {
                PostAdd(editingPost: $newPost)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("취소") {
                                newPost = Post(username: "유저 이름", content: "")
                                showAddView = false
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("게시") {
                                list.insert(newPost, at: 0)
                                showAddView = false
                                newPost = Post(username: "유저 이름", content: "")
                            }
                        }
                    }
            }
        }
        
    }
}

/// post 등록하는 View
struct PostAdd: View {
    @FocusState private var focused: Bool
    @Binding var editingPost: Post
    
    var body: some View {
        VStack {
            TextField("포스트를 입력해주세요...", text: $editingPost.content)
                .font(.title)
                .padding()
                .padding(.top)
                .focused($focused)
                .onAppear { focused = true }
            Spacer()
        }
        .navigationTitle("포스트 게시")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

/// PostRow가 선택되면 이동할 NavigationView
struct PostDetail: View {
    @State private var showEditView: Bool = false
//    let post: Post
    @Binding var post: Post
    @State private var editingPost = Post(username: "유저 이름", content: "")
    
//    @ObservedObject var postVM: PostViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(post.username)
            Text(post.content)
                .font(.largeTitle)
            
            Button(action: {
                showEditView = true
            }, label: {
                Image(systemName: "pencil")
                Text("수정")
            })
            .fullScreenCover(isPresented: $showEditView) {
                NavigationView {
                    PostAdd(editingPost: $editingPost)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("취소") {
                                    post = editingPost
                                    showEditView = false
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("게시") {
                                    post = editingPost
                                    showEditView = false
                                }
                            }
                        }
                }
                
            }
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
    var content: String
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
    ContentView()
//    PostRow(post: Post(username: "스티브", content: "안녕하세요"))
//    PostDetail(post: Post(username: "스티브", content: "안녕하세요"))
//    PostAdd() { post in }
//        NavigationView {
//            Forum()
//        }
}

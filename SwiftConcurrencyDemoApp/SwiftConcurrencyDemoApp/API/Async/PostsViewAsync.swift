//
//  PostsViewAsync.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import SwiftUI

struct PostsViewAsync: View {
    @State private var vm = PostsViewModelAsync()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Loading...")
                } else if let msg = vm.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(msg)
                    )
                } else {
                    List(vm.posts) { post in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(post.title)
                                .font(.headline)
                                .lineLimit(2)

                            Text(post.body)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(3)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Posts (async/await)")
            .toolbar {
                Button("Reload") {
                    Task { await vm.loadPosts() }
                }
            }
        }
        // SwiftUI automatically cancels this task if the view disappears.
        .task {
            await vm.loadPosts()
        }
    }
}

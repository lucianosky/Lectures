//
//  PostsViewGCD.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import SwiftUI

struct PostsViewGCD: View {
    @State private var vm = PostsViewModelGCD()

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
            .navigationTitle("Posts (GCD)")
            .toolbar {
                Button("Reload") {
                    vm.loadPosts()
                }
            }
        }
        .onAppear {
            vm.loadPosts()
        }
    }
}

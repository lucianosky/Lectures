//
//  PostsViewModelAsync.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class PostsViewModelAsync {
    var posts: [Post] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            posts = try JSONDecoder().decode([Post].self, from: data)
        } catch {
            // Ignore cancellation errors (common pattern in real apps)
            if !Task.isCancelled {
                errorMessage = error.localizedDescription
            }
        }
    }
}

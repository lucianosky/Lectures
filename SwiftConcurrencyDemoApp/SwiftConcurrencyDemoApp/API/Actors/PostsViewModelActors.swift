//
//  PostsViewModelActors.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class PostsViewModelActors {
    var posts: [Post] = []
    var isLoading = false
    var errorMessage: String?

    private let api: PostsAPI

    init(api: PostsAPI = PostsAPI()) {
        self.api = api
    }

    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            posts = try await api.fetchPosts()
        } catch is CancellationError {
            // ignore
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

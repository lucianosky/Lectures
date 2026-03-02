//
//  PostViewModel.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class PostsViewModelGCD {
    var posts: [Post] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func loadPosts() {
        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // GCD: hop to main to mutate UI state
            DispatchQueue.main.async {
                guard let self else { return }
                self.isLoading = false

                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data else {
                    self.errorMessage = "No data received."
                    return
                }

                do {
                    self.posts = try JSONDecoder().decode([Post].self, from: data)
                } catch {
                    self.errorMessage = "Decoding failed: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

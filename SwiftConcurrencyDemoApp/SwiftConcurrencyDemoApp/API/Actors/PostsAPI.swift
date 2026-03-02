//
//  PostsAPI.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation

actor PostsAPI {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func fetchPosts() async throws -> [Post] {
        let (data, response) = try await URLSession.shared.data(from: url)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Post].self, from: data)
    }
}

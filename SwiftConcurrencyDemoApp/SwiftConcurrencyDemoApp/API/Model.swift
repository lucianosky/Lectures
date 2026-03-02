
//
//  Model.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation

struct Post: Identifiable, Decodable {
    let id: Int
    let title: String
    let body: String
}

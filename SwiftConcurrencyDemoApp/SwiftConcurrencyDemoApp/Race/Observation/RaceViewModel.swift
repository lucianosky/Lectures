//
//  RaceViewModel.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class RaceViewModel: RaceViewModelProtocol {

    private(set) var counterResult: Int = 0
    let displayName: String = "Race condition"

    func runDataRace() {
        var counter = 0
        let queue = DispatchQueue.global(qos: .userInitiated)
        let group = DispatchGroup()

        for _ in 0..<1_000 {
            group.enter()
            queue.async {
                counter += 1 // intentionally racy
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.counterResult = counter
        }
    }
}

//
//  RaceViewModelSemaphore.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class RaceViewModelSemaphore: RaceViewModelProtocol {

    private(set) var counterResult: Int = 0
    let displayName: String = "Semaphore Fix"

    func runDataRace() {
        var counter = 0

        let queue = DispatchQueue.global(qos: .userInitiated)
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)

        for _ in 0..<1_000 {
            group.enter()
            queue.async {
                semaphore.wait()
                counter += 1
                semaphore.signal()

                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.counterResult = counter
        }
    }
}

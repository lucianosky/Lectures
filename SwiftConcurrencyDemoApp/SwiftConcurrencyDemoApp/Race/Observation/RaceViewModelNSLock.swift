//
//  RaceViewModelNSLock.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class RaceViewModelNSLock: RaceViewModelProtocol {

    private(set) var counterResult: Int = 0
    let displayName: String = "NSLock Fix"

    func runDataRace() {
        var counter = 0

        let queue = DispatchQueue.global(qos: .userInitiated)
        let group = DispatchGroup()
        let lock = NSLock()

        for _ in 0..<1_000 {
            group.enter()
            queue.async {
                lock.lock()
                counter += 1
                lock.unlock()

                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.counterResult = counter
        }
    }
}

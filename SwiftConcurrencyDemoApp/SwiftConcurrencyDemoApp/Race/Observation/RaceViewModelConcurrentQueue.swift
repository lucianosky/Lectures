//
//  RaceViewModelSerialQueue.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class RaceViewModelConcurrentQueue: RaceViewModelProtocol {

    private(set) var counterResult: Int = 0
    let displayName: String = "Concurrent Queue Fix"

    func runDataRace() {
        var counter = 0

        let queue = DispatchQueue(label: "counter.concurrent", attributes: .concurrent)
        let group = DispatchGroup()

        for _ in 0..<1_000 {
            group.enter()
            queue.async(flags: .barrier) {
                counter += 1
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.counterResult = counter
        }
    }
}

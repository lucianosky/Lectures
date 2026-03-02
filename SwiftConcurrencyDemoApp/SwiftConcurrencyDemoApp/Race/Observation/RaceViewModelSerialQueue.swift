//
//  RaceViewModelSerialQueue.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Observation

@Observable
final class RaceViewModelSerialQueue: RaceViewModelProtocol {

    private(set) var counterResult: Int = 0
    let displayName: String = "Serial Queue Fix"

    func runDataRace() {
        var counter = 0

        let workQueue = DispatchQueue.global(qos: .userInitiated)
        let counterQueue = DispatchQueue(label: "com.demo.counter.serial")
        let group = DispatchGroup()

        for _ in 0..<1_000 {
            group.enter()
            workQueue.async {
                counterQueue.async {
                    counter += 1
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.counterResult = counter
        }
    }
}

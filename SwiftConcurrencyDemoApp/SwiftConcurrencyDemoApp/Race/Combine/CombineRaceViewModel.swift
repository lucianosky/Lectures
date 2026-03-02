//
//  DataRaceViewModel.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Foundation
import Combine

final class CombineRaceViewModel: CombineRaceViewModelProtocol {

    @Published var counterResult: Int = 0

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

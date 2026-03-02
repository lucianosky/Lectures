//
//  DataRaceViewModelProtocol.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import Combine

protocol RaceViewModelProtocol: AnyObject {
    var counterResult: Int { get }
    var displayName: String { get }
    func runDataRace()
}

protocol CombineRaceViewModelProtocol: ObservableObject {
    var counterResult: Int { get }
    func runDataRace()
}

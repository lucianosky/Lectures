//
//  ContentView.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 25/02/26.
//

import SwiftUI

struct CombineRaceView: View {

    @StateObject private var viewModel = CombineRaceViewModel()
    @State private var buttonClicks = 0

    var body: some View {
        VStack(spacing: 24) {
            Text("Final Counter: \(viewModel.counterResult)")
                .font(.title2)
                .foregroundStyle(.blue)

            Button("Run Data Race Example") {
                viewModel.runDataRace()
                buttonClicks += 1
            }
            .buttonStyle(.borderedProminent)

            Text("Button clicks: \(buttonClicks)")
                .font(.default)
                .foregroundStyle(.blue)

        }
        .padding()
        .navigationTitle("Data Race (Combine)")
    }
}

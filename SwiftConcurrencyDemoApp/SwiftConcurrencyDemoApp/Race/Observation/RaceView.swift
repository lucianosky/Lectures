//
//  RaceView.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 26/02/26.
//

import SwiftUI

struct RaceView<VM: RaceViewModelProtocol>: View {

    @State private var viewModel: VM
    @State private var buttonClicks = 0

    init(viewModel: VM) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 24) {
            
            Text(viewModel.displayName)
                .font(.largeTitle)
                .foregroundStyle(.blue)

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
        .navigationTitle("Data Race")
    }
}

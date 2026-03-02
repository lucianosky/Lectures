//
//  ContentView.swift
//  SwiftConcurrencyDemoApp
//
//  Created by Luciano Sclovsky on 25/02/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(spacing: 5) {
                    
                    DemoNavigationButton(
                        title: "Data race",
                        destination: RaceView(viewModel: RaceViewModel())
                    )
                    
                    DemoNavigationButton(
                        title: "Data race (Semaphore Fix)",
                        destination: RaceView(viewModel: RaceViewModelSemaphore())
                    )
                    
                    DemoNavigationButton(
                        title: "Data race (Serial Queue Fix)",
                        destination: RaceView(viewModel: RaceViewModelSerialQueue())
                    )
                    
                    DemoNavigationButton(
                        title: "Data race (Concurrent Queue Fix)",
                        destination: RaceView(viewModel: RaceViewModelConcurrentQueue())
                    )
                    
                    DemoNavigationButton(
                        title: "Data race (Concurrent NSLock Fix)",
                        destination: RaceView(viewModel: RaceViewModelNSLock())
                    )
                    
                    DemoNavigationButton(
                        title: "Data race (Combine)",
                        destination: CombineRaceView()
                    )
                    
                    DemoNavigationButton(
                        title: "API - GCD",
                        destination: PostsViewGCD()
                    )

                    DemoNavigationButton(
                        title: "API - Async",
                        destination: PostsViewAsync()
                    )

                    DemoNavigationButton(
                        title: "API - Actors",
                        destination: PostsViewActors()
                    )

                }
                .padding()
            }
            .navigationTitle("Concurrency Demo")
        }
    }
}

struct DemoNavigationButton<Destination: View>: View {

    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .font(.default)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
        .padding(10)
    }
}
#Preview {
    ContentView()
}

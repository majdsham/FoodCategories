//
//  ContentView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = HomeViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await vm.fetchMenu()
        }
    }
}

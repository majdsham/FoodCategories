//
//  AppViewModel.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 24/09/2025.
//

import Combine

@MainActor
class AppViewModel: ObservableObject {
    @Published var isConnected: Bool = true
    @Published var state: State = .idle
    var isLoading = false
    var networkCancellable: AnyCancellable?
    
    init() {
        observeNetwork()
    }
    
    func observeNetwork() {
        networkCancellable = NetworkMonitor.shared.$isConnected
            .sink { [weak self] connected in
                self?.networkChanged(connected)
            }
    }
    
    func networkChanged(_ connected: Bool) {
        isConnected = connected
    }
}

extension AppViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case empty
        case error(String)
    }
}

//
//  NetworkMonitor.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 24/09/2025.
//

import Network
import Combine

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    @Published private(set) var isConnected: Bool = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}

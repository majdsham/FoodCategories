//
//  HomeVM.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//


import Foundation
import Combine

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}

@MainActor
final class HomeViewModel: AppViewModel {
    private let service: HomeServicing
    private let menuPeresistenseService: MenuPSProtocol
    private var cancellables = Set<AnyCancellable>()
    init(
        service: HomeServicing = HomeService(),
        menuPeresistenseService: MenuPSProtocol = MenuPS(),
    ) {
        self.service = service
        self.menuPeresistenseService = menuPeresistenseService
    }
    
    @Published var menu: MenuModel?
    
    func fetchMenu() async {
        guard !isLoading else { return }
        isLoading = true
        state = .loading
        if !isConnected {
            await loadMenurFromPersistence()
            return
        }
        fetchMenuFromServer()
    }
    
    private func loadMenurFromPersistence() async {
        do {
            if let menu = try await menuPeresistenseService.get(), !menu.isEmpty() {
                self.menu = menu
            } else {
                self.isLoading = false
                self.state = .error("You are offline and there is no local data to show.")
            }
        } catch {
            self.isLoading = false
            self.state = .error("Error fetching data from local storage.")
        }
    }
    
    private func fetchMenuFromServer() {
        service.fetchMenu()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    self.state = .loaded
                case .failure(let error):
                    self.state = .error(error.message)
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                guard let menu = response?.record?.menu else { return }
                self.menu = menu
                self.saveMenu(menu)
            }
            .store(in: &cancellables)
    }
    
    private func saveMenu(_ menu: MenuModel) {
        Task {
            do {
                try await self.menuPeresistenseService.replace(menu: menu)
            }
            catch {
                self.state = .error("Error saving data to local storage.")
            }
        }
    }
}

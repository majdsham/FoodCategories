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
final class HomeVM: AppViewModel {
    private let service: HomeServicing
    private let menuPeresistenseService: MenuPSProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // 1. The designated initializer, which requires dependencies to be passed in.
    init(
        service: HomeServicing,
        menuPeresistenseService: MenuPSProtocol
    ) {
        self.service = service
        self.menuPeresistenseService = menuPeresistenseService
        super.init()
    }
    
    // 2. The convenience initializer, which provides default dependencies.
    convenience override init() {
        self.init(
            service: HomeService(),
            menuPeresistenseService: MenuPS()
        )
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
    
    func menuOptionAccodingCategory(category: MenuCategory) -> [any MenuOptionProtocol] {
        switch category {
        case .drinks:
            return menu?.drinks ?? []
        case .pasta:
            return menu?.pasta ?? []
        case .hamburgers:
            return menu?.hamburgers ?? []
        case .sandwiches:
            return menu?.sandwiches ?? []
        }
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
    
    private func fetchMenuFromServerAync() async {
        do {
            if let result = try await service.fetchMenuAsync() {
                self.menu = result.record?.menu
            }
        } catch let error {
            self.state = .error(error.localizedDescription)
        }
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

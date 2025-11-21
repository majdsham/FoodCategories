//
//  HomeView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 10/21/25.
//

import SwiftUI

struct HomeView: View {
    @State private var homeRouter = AppRouter()
    @StateObject private var vm = HomeVM()
    private let viewWhiteBackgroundColor = Color(#colorLiteral(red: 0.9765624404, green: 0.9765624404, blue: 0.9765624404, alpha: 1))
    private let viewRedBackgroundColor = Color(.accent)
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack(path: $homeRouter.path) {
            ZStack {
                HStack(spacing: 0) {
                    viewRedBackgroundColor.frame(width: 120)
                    viewWhiteBackgroundColor
                }
                .edgesIgnoringSafeArea(.all)
                
                Group {
                    switch vm.state {
                    case .idle, .loading:
                        AppDefaultIndicator()
                            .frame(width: 50)
                    case .loaded:
                        mainContentView
                    case .empty:
                        Text("No menu items found.")
                            .foregroundColor(.secondary)
                    case .error(let errorMessage):
                        VStack(spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text(errorMessage)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationDestination(for: HomeDestination.self) { destination in
                switch destination {
                case .openDetails(category: let category):
                    MenuListView(category: category, items: vm.menuOptionAccodingCategory(category: category))
                }
            }
        }
        .task {
            await vm.fetchMenu()
        }
        .environmentObject(vm)
        .environment(homeRouter)
    }
    
    private var mainContentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(MenuCategory.allCases) { category in
                    CategoryCard(category: category, numberOfItemInCategory: vm.menuOptionAccodingCategory(category: category).count)
                }
//                LocalizedTextView(key: MainTabsLocalizationKeys.home)
//                    .foregroundStyle(.accent)
//                    .font(.headline)
//                Toggle("test", isOn: $isPresented)
//                    .onChange(of: isPresented) { isPresented in
//                        print("isPresented: \(isPresented)")
//                        LocalizationManager.shared.currentLanguage = isPresented ? .en : .ar
//                    }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    HomeView()
}

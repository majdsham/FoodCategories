//
//  MainTabsView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/6/25.
//

import SwiftUI

struct MainTabsView: View {
    @State var selectedTab: AppMainTabsEnum = .home
    @State private var tabRouter: TabViewRouter = TabViewRouter()
    var body: some View {
        NavigationStack(path: $tabRouter.path) {
                TabView(selection: $selectedTab) {
                    Tab("Home", systemImage: "house", value: AppMainTabsEnum.home) {
                        NavigationStack {
                            HomeView()
                        }
                    }
                    Tab("Search", systemImage: "magnifyingglass", value: AppMainTabsEnum.search, role: .search) {
                        NavigationStack {
//                            SearchView()
                        }
                    }
                }
        }
        .environment(tabRouter)
    }
}

//extension Text: TabContent {
//    public typealias Body = <#type#>
//    
//    public typealias TabValue = <#type#>
//    
//    
//}

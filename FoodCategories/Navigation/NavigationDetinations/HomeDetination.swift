//
//  HomeDetination.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 11/5/25.
//

enum HomeDestination: Hashable {
    case openDetails(category: MenuCategory)
    //    // 1. Manually implement ==
    //        static func == (lhs: HomeDestination, rhs: HomeDestination) -> Bool {
    //            switch (lhs, rhs) {
    //            case (.openDetails(let lhsCategory, let lhsItems), .openDetails(let rhsCategory, let rhsItems)):
    //                // A) Check if categories are equal
    //                guard lhsCategory == rhsCategory else { return false }
    //
    //                // B) Check if the arrays of items are equal.
    //                //    We can't compare `[any MenuOptionProtocol]` directly.
    //                //    We must "erase" them to `AnyHashable` first, then compare.
    //                let lhsAnyHashable = lhsItems.map { AnyHashable($0) }
    //                let rhsAnyHashable = rhsItems.map { AnyHashable($0) }
    //
    //                return lhsAnyHashable == rhsAnyHashable
    //            }
    //        }
    //
    //        // 2. Manually implement hash(into:)
    //        func hash(into hasher: inout Hasher) {
    //            switch self {
    //            case .openDetails(let category, let items):
    //                // A) Hash the category
    //                hasher.combine(category)
    //
    //                // B) Loop through the items and hash each one.
    //                //    This works because we know each item *is* Hashable.
    //                for item in items {
    //                    hasher.combine(item)
    //                }
    //            }
    //        }
}

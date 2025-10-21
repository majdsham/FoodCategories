//
//  HomeService.swift
//  FoodCategories2
//
//  Created by Majd Aldeyn Ez Alrejal on 05/09/2025.
//


import Combine

protocol HomeServicing {
    func fetchMenu() -> AnyPublisher<RecordResponseModel?, ErrorResponse>
}

final class HomeService: HomeServicing {
    func fetchMenu() -> AnyPublisher<RecordResponseModel?, ErrorResponse> {
        return CombineApiClient.shared
            .request(RecordResponseModel?.self,
                     endPoint: .init(path: EndPoints.Data.All))
            .map(\.self)
            .eraseToAnyPublisher()
    }
}

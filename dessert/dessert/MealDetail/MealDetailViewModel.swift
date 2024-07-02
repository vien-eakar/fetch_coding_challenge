//
//  MealDetailViewModel.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published private(set) var status = Status.notStarted
    @Published private(set) var mealDetail: MealDetailModel!
    
    private let fetchController: FetchController
    
    init(fetchController: FetchController) {
        self.fetchController = fetchController
    }
    
    func fetchData(mealId: String) async {
        self.status = .fetching
        
        do {
            let data = try await fetchController.fetchMealDetail(mealId: mealId)
            if let data = data {
                self.mealDetail = data.listMeals[0]
            }
            self.status = .success
        }catch {
            self.status = .failed(error: error)
        }
    }
}

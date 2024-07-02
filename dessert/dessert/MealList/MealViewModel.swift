//
//  MealViewModel.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import Foundation
@MainActor
class MealViewModel: ObservableObject {
    @Published private(set) var status = Status.notStarted
    private(set) var originalList = [MealModel]()
    @Published private(set) var listMeals = [MealModel]()
    
    private let fetchController: FetchController
    
    init(fetchController: FetchController) {
        self.fetchController = fetchController
    }
    
    func fetchMeal(category: String) async {
        self.status = .fetching
        do {
            let data = try await self.fetchController.fetchMeal(category: category)
            if let listData = data?.listMeal {
                self.originalList = listData
            }
            self.sortList(alphabetical: true)
            self.status = .success
        }catch {
            self.status = .failed(error: error)
        }
    }
    
    func sortList(alphabetical: Bool) {
        listMeals = alphabetical ? originalList.sorted{$0.mealName < $1.mealName} : originalList.sorted{$0.mealId < $1.mealId}
    }
}


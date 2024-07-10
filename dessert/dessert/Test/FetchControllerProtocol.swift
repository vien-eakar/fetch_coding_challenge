//
//  FetchControllerProtocol.swift
//  dessert
//
//  Created by Nguyen Vien on 7/9/24.
//

import Foundation

protocol FetchControllerProtocol {
 
    func fetchMeal(category: String) async throws -> Meals?
    func fetchMealDetail(mealId: String) async throws -> MealDetails?
    
}

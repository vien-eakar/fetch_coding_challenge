//
//  FetchControl.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import Foundation

struct FetchController {
    private let fetchMealURL = "https://themealdb.com/api/json/v1/1/filter.php?c=%@"
    private let fetchMealDetailUrl = "https://themealdb.com/api/json/v1/1/lookup.php?i=%@"
    
    func fetchMeal(category: String) async throws -> Meals? {
        guard let url = URL(string: String(format: fetchMealURL, category)) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let resultData = try? JSONDecoder().decode(Meals.self, from: data) else {
            throw NetworkError.badData
        }
        return resultData
    }
    
    func fetchMealDetail(mealId: String) async throws -> MealDetails? {
        guard let url = URL(string: String(format: fetchMealDetailUrl, mealId)) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let resultData = try? JSONDecoder().decode(MealDetails.self, from: data) else {
            throw NetworkError.badData
        }
        return resultData
    }
    
    
}


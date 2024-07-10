//
//  FetchControllerTest.swift
//  dessert
//
//  Created by Nguyen Vien on 7/9/24.
//

import Foundation

struct FetchControllerTest: FetchControllerProtocol {
    
    // case BadURL
    func fetchMeal(category: String) async throws -> Meals? {
        //guard let url = URL(string: String(format: fetchMealURL, category)) else {
            throw NetworkError.badURL
       // }
        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw NetworkError.badResponse
//        }
//        
//        guard let resultData = try? JSONDecoder().decode(Meals.self, from: data) else {
//            throw NetworkError.badData
//        }
//        return resultData
    }
    
    func fetchMealDetail(mealId: String) async throws -> MealDetails? {
//        guard let url = URL(string: String(format: fetchMealDetailUrl, mealId)) else {
//            throw NetworkError.badURL
//        }
//        
//        let (data, response) = try await URLSession.shared.data(from: url)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw NetworkError.badResponse
//        }
//        
//        guard let resultData = try? JSONDecoder().decode(MealDetails.self, from: data) else {
//            throw NetworkError.badData
//        }
        
//        return resultData
        return nil
    }
}

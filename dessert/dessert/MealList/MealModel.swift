//
//  MealModel.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import Foundation

struct MealModel: Codable, Identifiable {
    let mealName: String
    let mealId: String
    let mealImage: URL
    var favorited: Bool = false
    
    var id: String { mealId }
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealId = "idMeal"
        case mealImage = "strMealThumb"
    }
}

struct Meals: Codable {
    let listMeal: [MealModel]
    
    enum CodingKeys: String, CodingKey {
        case listMeal = "meals"
    }
}

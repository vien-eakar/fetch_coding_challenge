//
//  MealDetailModel.swift
//  dessert
//
//  Created by Nguyen Vien on 7/1/24.
//

import Foundation

struct MealDetailModel: Codable {
    let mealName: String
    let mealId: String
    let mealImage: URL
    let instructions: String!
    let ingredients: [String]
    let measures: [String]
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealId = "idMeal"
        case mealImage = "strMealThumb"
        case instructions = "strInstructions"
        case ingredients = "strIngredient"
        case measures = "strMeasure"
    }
    
    struct DynamicKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }

        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealName = try container.decode(String.self, forKey: .mealName)
        self.mealId = try container.decode(String.self, forKey: .mealId)
        self.mealImage = try container.decode(URL.self, forKey: .mealImage)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        // check this food id is favarite or not
        
        
        var ingredients: [String] = []
        var measures: [String] = []
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        
        for i in 1...20 {
            let ingredientKey = DynamicKey(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicKey(stringValue: "strMeasure\(i)")!
            
            if let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            
            if let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey), !measure.isEmpty {
                measures.append(measure)
            }
        }
        self.ingredients = ingredients
        self.measures = measures
    }
}

struct MealDetails: Codable {
    let listMeals: [MealDetailModel]
    
    enum CodingKeys: String, CodingKey {
        case listMeals = "meals"
    }
}

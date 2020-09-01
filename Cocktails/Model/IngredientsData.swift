//
//  IngredientsData.swift
//  wineCatalog
//
//  Created by Daria Pr on 29.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

struct IngredientsData: Codable {
    let ingredients: [Ingredients]
}

struct Ingredients: Codable {
    let strIngredient: String
    let strDescription: String
}

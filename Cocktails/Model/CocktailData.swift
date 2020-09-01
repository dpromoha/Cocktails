//
//  CocktailData.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

struct CocktailData: Codable {
    let drinks: [Drinks]
}

struct Drinks: Codable {
    let strDrink: String
    let strAlcoholic: String
    let strInstructions: String
    let strDrinkThumb: String
}

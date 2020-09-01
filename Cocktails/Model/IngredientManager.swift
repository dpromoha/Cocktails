//
//  IngredientManager.swift
//  wineCatalog
//
//  Created by Daria Pr on 29.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

protocol IngredientManagerDelegate {
    func didUpdateView(IngredientManager: IngredientManager, IngredientStruct: IngredientStruct)
    func didFailWithError(error: Error)
}

struct IngredientManager {
    var delegate: IngredientManagerDelegate?
    var parseInfo = ParseInfo()
    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?i="
    
    func getIngredientInfo(for name: String) {
        let ingredientName = parseInfo.checkWhitespaces(name: name)
        let urlString = "\(baseURL)\(ingredientName)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let ingredientsData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateView(IngredientManager: self, IngredientStruct: ingredientsData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> IngredientStruct? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(IngredientsData.self, from: data)
            let nameLbl = decodedData.ingredients[0].strIngredient
            let nameDescript = decodedData.ingredients[0].strDescription
            let ingred = IngredientStruct(ingred: nameLbl, ingredDescrip: nameDescript)
            return ingred
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

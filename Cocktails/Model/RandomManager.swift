//
//  RandomManager.swift
//  wineCatalog
//
//  Created by Daria Pr on 29.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

protocol RandomManagerDelegate {
    func didUpdateView(RandomManager: RandomManager, RandomStruct: CocktailsStruct)
    func didFailWithError(error: Error)
}

struct RandomManager {
    var delegate: RandomManagerDelegate?

    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
    
    func getRandom() {
        if let url = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let randomData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateView(RandomManager: self, RandomStruct: randomData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CocktailsStruct? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CocktailData.self, from: data)
            let nameLbl = decodedData.drinks[0].strDrink
            let recipeLbl = decodedData.drinks[0].strInstructions
            let alcoLbl = decodedData.drinks[0].strAlcoholic
            let photo = decodedData.drinks[0].strDrinkThumb
            let cocktail = CocktailsStruct(nameLbl: nameLbl, alcoLbl: alcoLbl, recipeLbl: recipeLbl, photo: photo)
            return cocktail
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


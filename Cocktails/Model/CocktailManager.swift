//
//  CocktailManager.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

protocol CocktailManagerDelegate {
    func didUpdateView(CocktailManager: CocktailManager, CocktailStr: CocktailsStruct)
    func didFailWithError(error: Error)
}

struct CocktailManager {
    var delegate: CocktailManagerDelegate?
    var parseInfo = ParseInfo()
    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="

    func getCocktailInfo(for name: String) {
        let cocktailsName = parseInfo.checkWhitespaces(name: name)
        let urlString = "\(baseURL)\(cocktailsName)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let cocktailsData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateView(CocktailManager: self, CocktailStr: cocktailsData)
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

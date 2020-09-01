//
//  IngredientsVC.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import UIKit

class IngredientsVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var ingredientManager = IngredientManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientManager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchWasPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

extension IngredientsVC: IngredientManagerDelegate {
        func didUpdateView(IngredientManager: IngredientManager, IngredientStruct: IngredientStruct) {
            
            DispatchQueue.main.async {
                self.nameLbl.text = IngredientStruct.ingred
                self.textView.text = IngredientStruct.ingredDescrip
            }
        }
        
        func didFailWithError(error: Error) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Not found", message: "Please, be sure you don’t made mistakes", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            print(error)
        }
        
}

extension IngredientsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please, type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let nameIngredients = searchTextField.text {
            ingredientManager.getIngredientInfo(for: nameIngredients)
        }
        searchTextField.text = ""
    }

}

//
//  CocktailsVC.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import UIKit

class CocktailsVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var alcoLbl: UILabel!
    @IBOutlet weak var recipeLbl: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var cocktailManager = CocktailManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        cocktailManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

extension CocktailsVC: UITextFieldDelegate {
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
        if let nameCocktails = searchTextField.text {
            cocktailManager.getCocktailInfo(for: nameCocktails)
        }
        searchTextField.text = ""
    }

}

extension CocktailsVC: CocktailManagerDelegate {
    
    func didUpdateView(CocktailManager: CocktailManager, CocktailStr: CocktailsStruct) {
        DispatchQueue.main.async {
            self.nameLbl.text = CocktailStr.nameLbl
            self.alcoLbl.text = CocktailStr.alcoLbl
            self.recipeLbl.text = CocktailStr.recipeLbl

            if let url = URL(string: CocktailStr.photo) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.photo.image = image
                    }
                }
            }
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

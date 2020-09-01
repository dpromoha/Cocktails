//
//  CoctailsVC.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import UIKit

class CocktailsVC: UIViewController, CocktailManagerDelegate {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var alcoLbl: UILabel!
    @IBOutlet weak var recipeLbl: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var searchTextField: UISearchBar!
    
    var cocktailManager = CocktailManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailManager.delegate = self
        cocktailManager.getCocktailInfo(for: "Artillery_Punch")//значение должно приходить из uitextfield
    }
    
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
        print(error)
    }


}


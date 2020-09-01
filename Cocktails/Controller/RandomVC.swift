//
//  RandomVC.swift
//  wineCatalog
//
//  Created by Daria Pr on 28.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import UIKit

class RandomVC: UIViewController {
    
    @IBOutlet weak var photoLbl: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var alcoLbl: UILabel!
    @IBOutlet weak var recipeLbl: UITextView!
    
    var randomManager = RandomManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomManager.delegate = self
    }
    
    @IBAction func randomWasPressed(_ sender: UIButton) {
        randomManager.getRandom()
    }
    
}

extension RandomVC: RandomManagerDelegate {
    
    func didUpdateView(RandomManager: RandomManager, RandomStruct: CocktailsStruct) {
        
        DispatchQueue.main.async {
            self.nameLbl.text = RandomStruct.nameLbl
            self.alcoLbl.text = RandomStruct.alcoLbl
            self.recipeLbl.text = RandomStruct.recipeLbl
            
            
            if let url = URL(string: RandomStruct.photo) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        self.photoLbl.image = image
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

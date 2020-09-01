//
//  ParseInfo.swift
//  wineCatalog
//
//  Created by Daria Pr on 29.08.2020.
//  Copyright © 2020 Daria. All rights reserved.
//

import Foundation

struct ParseInfo {

    func checkWhitespaces(name: String) -> String {
        var detectWhitespace: Int = 0

        for i in name {
            if i.isWhitespace {
                detectWhitespace += 1
            }
        }
        if detectWhitespace == name.count {
            return name
        } else {
            let toArray = name.components(separatedBy: " ")
            let backToString = toArray.joined(separator: "_")
            return backToString
        }
    }
    
}

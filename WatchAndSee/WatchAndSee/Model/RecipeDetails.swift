//
//  RecipeDetails.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 11/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct RecipeDetails {

    var duration: String
    var portions: String
    var ingredients: [String]

    init(duration: String, portions: String, ingredients: [String]) {
        self.duration = duration
        self.portions = portions
        self.ingredients = ingredients
    }
}

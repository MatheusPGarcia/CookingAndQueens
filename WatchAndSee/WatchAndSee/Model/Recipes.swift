//
//  Recipes.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

/// Model that holds Recipes variables
struct Recipes {
    typealias InternalType = Recipes

    var name: String
    var ingredients: [String]
    var time: String
    var rendiment: String
    var photo: String
    var steps: [Step]

    init(name: String, ingredients: [String], time: String, rendiment: String, photo: String, steps: [Step]) {
        self.name = name
        self.ingredients = ingredients
        self.time = time
        self.rendiment = rendiment
        self.photo = photo
        self.steps = steps
    }
}

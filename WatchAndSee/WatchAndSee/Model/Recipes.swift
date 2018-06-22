//
//  Recipes.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Recipes: Codable {

    var name: String
    var ingredients: [String]
    var time: String
    var rendiment: String
    var steps: [Step]

    init() {
        self.name = ""
        self.ingredients = []
        self.time = ""
        self.rendiment = ""
        self.steps = []
    }

    mutating func setValues(_ name: String, _ ing: [String], _ time: String, _ rendiment: String, _ steps: [Step]) {
        self.name = name
        self.ingredients = ing
        self.time = time
        self.rendiment = rendiment
        self.steps = steps

    }

}

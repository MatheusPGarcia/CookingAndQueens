//
//  Category.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Category {

    var name: String
    var elements: [String]
    var recipes: [Recipes]

    init() {
        self.name = ""
        self.elements = []
        self.recipes = []
    }

    mutating func setValues(_ name: String, _ elements: [String]) {
        self.name = name
        self.elements = elements
    }

}

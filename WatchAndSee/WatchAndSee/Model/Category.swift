//
//  Category.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Category {
    typealias InternalType = Category

    var name: String
    var elements: [String]  // array of String with recipes names that the category contains
    var recipes: [Recipes]  // array of recipes with the names held in elements

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

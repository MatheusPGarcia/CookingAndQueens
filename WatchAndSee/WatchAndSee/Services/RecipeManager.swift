//
//  RecipeManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {

    var recipe = Recipes()

    func setRecipe(name: String, ing: [String], time: String, portions: Int) {
        recipe.name = name
        recipe.ingredients = ing
        recipe.time = time
        recipe.portions = portions
    }
}

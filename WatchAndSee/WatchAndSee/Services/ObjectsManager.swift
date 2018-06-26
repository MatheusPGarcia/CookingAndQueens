//
//  ObjectsManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Firebase

class ObjectsManager: UIViewController {
    var recipeList = [Recipes]()
    var categoryList = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func createRecipes(_ recipes: [Recipes], _ categories: [Category]) -> [Category] {
        var auxCat = Category()

        for category in categories {
            auxCat.name = category.name
            auxCat.elements = category.elements
            auxCat.recipes = getElements(category.elements, recipes)

            categoryList.append(auxCat)
        }

        return categoryList
    }

    func getElements(_ elements: [String], _ recipes: [Recipes]) -> [Recipes] {
        var result = [Recipes]()

        for index in 0...elements.count-1 {
            let search = elements[index]
            result = recipes.filter({ (rec) -> Bool in
                rec.name.lowercased().contains(search.lowercased())
            })
            print("RESULT: \(result)")

        }
        return result
    }
}

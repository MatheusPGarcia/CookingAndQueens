//
//  ObjectsManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ObjectsManager: NSObject {
    static var shared = ObjectsManager()

    var recipeList = [Recipes]()
    var categoryList = [Category]()

    /// Allocate recipes in each corresponding category.
    ///
    /// - Parameters:
    ///   - recipes: array of all the recipes in the database
    ///   - categories: array of category
    /// - Returns: array of category updated with each category corresponding recipes
    func createCategories(_ recipes: [Recipes], _ categories: [Category]) -> [Category] {
        var auxCat = Category()

        for category in categories {
            auxCat.name = category.name
            auxCat.elements = category.elements
            auxCat.recipes = getElements(category.elements, recipes)
            categoryList.append(auxCat)
        }

        return categoryList
    }

    // filters all recipes to return the right recipes to each category

    /// Filters all recipes to return the right one to each category
    ///
    /// - Parameters:
    ///   - elements: array of string holding all the recipes within the category
    ///   - recipes: array of all recipes in the database
    /// - Returns: array of Recipe
    func getElements(_ elements: [String], _ recipes: [Recipes]) -> [Recipes] {
        var result = [Recipes]()
        recipeList = []

        for index in 0...elements.count - 1 {
            let search = elements[index]
            result = recipes.filter({ (rec) -> Bool in
                rec.name.lowercased().contains(search.lowercased())
            })
            print("RESULT: \(result)")
            recipeList.append(result[0])

        }
        return recipeList
    }

    /// Process image to be displayed
    ///
    /// - Parameter url: String containing url link
    /// - Returns: UIImage to be displayed
    func setImage(url: String) -> UIImage {
        var data = Data()

        let imgURL = URL(string: url)
        do {
            try data = Data(contentsOf: imgURL!)
        } catch {
            print("Cannot load image")
        }
        let image = UIImage(data: data)
        return image!
    }
}

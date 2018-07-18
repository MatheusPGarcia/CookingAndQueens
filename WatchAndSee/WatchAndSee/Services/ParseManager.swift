//
//  ResponseParseManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 21/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import CloudKit

class ParseManager: NSObject {

    let databaseManager = DatabaseService()

    func parseCategories(completion: @escaping ([Category]) -> Void) {

        let category = "Category"
        var categoryArray: [Category] = []

        databaseManager.fetch(recordType: category, predicate: nil, reference: nil, completion: { (record) -> Void in

            for category in record {
                //swiftlint:disable force_cast
                let name = category["name"] as! String
                //swiftlint:enable force_cast
                let reference = category.recordID
                let newCategory = Category(name: name, reference: reference)

                categoryArray.append(newCategory)
            }

            completion(categoryArray)
        })
    }

    func parseRecipes(predicateName: CKRecordID, completion: @escaping ([Recipe]) -> Void) {

        let category = "Recipe"
        let predicate = "category"
        let reference = CKReference(recordID: predicateName, action: .deleteSelf)

        databaseManager.fetch(recordType: category, predicate: predicate, reference: reference) { (record) -> Void in

            var recipeArray: [Recipe] = []

            for recipe in record {
                //swiftlint:disable force_cast
                let name = recipe["name"] as! String
                //swiftlint:enable force_cast
                let reference = recipe.recordID
                let newRecipe = Recipe(name: name, reference: reference)
                recipeArray.append(newRecipe)
            }

            completion(recipeArray)
        }
    }

    func parseRecipeDetails(predicateName: CKRecordID, completion: @escaping (RecipeDetails) -> Void) {

        let category = "RecipeDetails"
        let predicate = "recipe"
        let reference = CKReference(recordID: predicateName, action: .deleteSelf)

        databaseManager.fetch(recordType: category, predicate: predicate, reference: reference) { (record) in

            let recordValue = record[0]
            //swiftlint:disable force_cast
            let duration = recordValue["duration"] as! String
            let portions = recordValue["portions"] as! String
            let ingredients = recordValue["ingredients"] as! [String]

            let recipeDetails = RecipeDetails(duration: duration, portions: portions, ingredients: ingredients)
            //swiftlint:enable force_cast

            completion(recipeDetails)
        }
    }

    func parseStep(predicateName: CKRecordID, completion: @escaping ([Step]) -> Void) {

        let category = "Step"
        let predicate = "recipe"
        let reference = CKReference(recordID: predicateName, action: .deleteSelf)

        databaseManager.fetch(recordType: category, predicate: predicate, reference: reference) { (record) in

            var stepsArray = [Step]()

            for currentStep in record {

                //swiftlint:disable force_cast
                let stepText = currentStep["description"] as! String
                let stepTime = currentStep["time"] as! Int?
                //swiftlint:enable force_cast

                let newStep = Step(text: stepText, time: stepTime)
                stepsArray.append(newStep)
            }

            completion(stepsArray)
        }
    }

     func parseImage(predicateName: CKRecordID, completion: @escaping (RecipeImage) -> Void) {

        let category = "RecipeImage"
        let predicate = "recipe"
        let reference = CKReference(recordID: predicateName, action: .deleteSelf)

        databaseManager.fetch(recordType: category, predicate: predicate, reference: reference) { (record) in

            let singleRecord = record[0]
            if let asset = singleRecord["image"] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL) {
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }

                    let imageObj = RecipeImage(image: image, reference: predicateName)
                    completion(imageObj)
                }
            }
        }
    }
}

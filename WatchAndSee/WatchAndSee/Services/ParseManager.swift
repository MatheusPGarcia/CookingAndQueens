//
//  ResponseParseManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 21/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ParseManager: NSObject {
    var ingredients = [String]()
    var steps = [Step]()
    var recipe: Recipes?

//    func parseData<T>(dump: T.Type, dataDic: [String: Any]) -> T {
//        if dump == Category.self {
//            let categoryItem = parseCategory(dataDic)
//            return categoryItem as! T
//        }
//        else if dump == Recipes.self {
//            return parseRecipe(dataDic) as! T
//        }
//        else {
//            print("No compatible type")
//            return T
//        }
//
//    }

    func parseCategory(_ snapshotDic: [String: Any]) -> Category {
        var categoryItem = Category()
        var catElements = [String]()

        guard let name = snapshotDic["Nome"] as? String else {
            print("No existing name")
            return Category()
        }

        guard let elements = snapshotDic["Itens"] else {
            print("No existing itens")
            return Category()
        }

        guard let elemDic = elements as? [String: Any] else {
            return Category()
        }
        // swiftlint:disable force_cast

        for element in elemDic {
            catElements.append(element.value as! String)
        }

        categoryItem.name = name
        categoryItem.elements = catElements

        return categoryItem
    }

    func parseRecipes(_ snapshotDic: [String: Any]) -> [Recipes] {
        return [Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])]
    }

    func parseRecipe(_ snapshotDic: [String: Any]) -> Recipes {

        guard let name = snapshotDic["Nome"] as? String else {
            print("No existing name")
            return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
        }

        guard let time = snapshotDic["Tempo de preparo"] as? String else {
            print("No existing prepare time")
            return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
        }
        let rendiment = snapshotDic["Rendimento"] as? String
        let ing = snapshotDic["Ingredientes"]!
        let stp = snapshotDic["Passos"]
        let photo = snapshotDic["Foto"] as? String

        ingredients = []
        steps = []

        guard let ingDictionary = ing as? [String: Any] else {
            return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
        }

        guard let stpDictionary = stp as? [String: Any] else {
            return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
        }

        // sort steps by numerical order
        let sortedSteps = stpDictionary.sorted(by: {$0.0 < $1.0})
        for element in ingDictionary {
            ingredients.append((element.value as? String)!)
        }

        for element in sortedSteps {
            guard let stp = element.value as? [String: Any] else {
                print("nao rolou")
                return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
            }
            if let text = stp["Texto"] as? String {

                let time = stp["Tempo"] as? Int

                var newStep = Step()

                newStep.text = text
                newStep.time = time

                steps.append(newStep)
            }
        }

        return Recipes(name: name,
                       ingredients: ingredients,
                       time: time,
                       rendiment: rendiment!,
                       photo: photo!,
                       steps: steps)
    }

}

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

    func parseRecipe(_ snapshotDic: [String: Any]) -> Recipes {
        let name = snapshotDic["nome"] as? String
        let time = snapshotDic["tempo"] as? String
        let rendiment = snapshotDic["rendimento"] as? String
        let ing = snapshotDic["Ingredientes"]!
        let stp = snapshotDic["Passos"]
        let photo = snapshotDic["foto"] as? String

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

        return Recipes(name: name!,
                       ingredients: ingredients,
                       time: time!,
                       rendiment: rendiment!,
                       photo: photo!,
                       steps: steps)
    }
}

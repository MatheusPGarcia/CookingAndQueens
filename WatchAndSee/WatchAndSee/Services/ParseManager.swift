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
    var recipe = Recipes()
    // swiftlint:disable force_cast

    func parseRecipe(_ snapshotDic: [String: Any]) -> Recipes {
        let name = snapshotDic["nome"] as! String
        let time = snapshotDic["tempo"] as! String
        let rendiment = snapshotDic["rendimento"] as! String
        let ing = snapshotDic["Ingredientes"]!
        let stp = snapshotDic["Passos"]

        guard let ingDictionary = ing as? [String: Any] else {
            print("deu merda")
            return recipe
        }

        guard let stpDictionary = stp as? [String: Any] else {
            print("deu merda")
            return recipe
        }

        for element in ingDictionary {
            ingredients.append(element.value as! String)
        }

        for element in stpDictionary {

            guard let stp = element.value as? [String: Any] else {
                print("nao rolou")
                return recipe
            }

            if let text = stp["Texto"] as? String {

                let time = stp["Tempo"] as? Int

                var newStep = Step()

                newStep.text = text
                newStep.time = time

                steps.append(newStep)
            }
        }

        recipe.setValues(name, ingredients, time, rendiment, steps)

        return recipe
    }
}

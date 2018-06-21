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
    var steps = [String]()
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
            steps.append(element.value as! String)
        }

       recipe.setValues(name, ingredients, time, rendiment, steps)
        return recipe
    }
}

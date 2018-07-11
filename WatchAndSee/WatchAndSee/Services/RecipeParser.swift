//
//  RecipeParser.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 11/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class RecipeParser: NSObject, PersistenceObject {
    typealias InternalType = Recipes
    static var shared = RecipeParser()

    var ingredients = [String]()
    var steps = [Step]()
    var recipe: Recipes?

    func parseData(dataDic: [String: Any]) -> Recipes {
         if let name = dataDic["Nome"] as? String,
            let time = dataDic["Tempo de preparo"] as? String,
            let rendiment = dataDic["Rendimento"] as? String,
            let ing = dataDic["Ingredientes"],
            let stp = dataDic["Passos"],
            let photo = dataDic["Foto"] as? String {

                ingredients = []
                steps = []

                guard let ingDictionary = ing as? [String: Any] else {
                    return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
                }

                for element in ingDictionary {
                    ingredients.append((element.value as? String)!)
                }

                guard let stpDictionary = stp as? [String: Any] else {
                    return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
                }
                // sort steps by numerical order
                let sortedSteps = stpDictionary.sorted(by: {$0.0 < $1.0})

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
                               rendiment: rendiment,
                               photo: photo,
                               steps: steps)
            }
        print("Incomplete dictionary in parseData object in RecipeParser")
        return Recipes(name: "", ingredients: [], time: "", rendiment: "", photo: "", steps: [])
    }
}

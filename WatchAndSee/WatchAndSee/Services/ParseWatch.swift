//
//  ParseWatch.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 25/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ParseWatch: NSObject {

    // return the value (dictionary) that will be sent to the apple watch
    func sendToWatch(recipe: Recipes) -> [String: Any?] {
        var valueToSend: [String: Any] = [:]
        var currentArray = valueToSend["steps"] as? [[String: Any]] ?? [[String: Any]]()

        for step in recipe.steps {

            var dict = [String: Any]()
            dict["Texto"] = step.text
            if let time = step.time {
                dict["Tempo"] = time
            }

            currentArray.append(dict)
        }

        valueToSend["steps"] = currentArray

        return valueToSend
    }

    // receives a dictionary and converts to Step array object
    func decodeInWatch(_ dataArray: [String: Any?]) -> [Step] {

        var steps: [Step] = []

        guard let data = dataArray["steps"] else { return steps }

        guard let singleData = data as? [[String: Any]] else { return steps }

        for stp in singleData {
            guard let text = stp["Texto"] as? String else { return steps }
            let time = stp["Tempo"] as? Int

            let newStep = Step(text: text, time: time)
            steps.append(newStep)
        }
        return steps
    }
}

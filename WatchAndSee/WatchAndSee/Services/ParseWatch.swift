//
//  ParseWatch.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 25/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ParseWatch: NSObject {

    func sendToWatch(recipe: Recipes) -> [String: Any?] {

        var valueToSend: [String: Any] = [:]
        var currentArray = valueToSend["items"] as? [[String: Any]] ?? [[String: Any]]()

        for step in recipe.steps {

            let step: [String: Any] = [
                "Texto": "\(step.text)",
                "Tempo": "\(String(describing: step.time))"
            ]

            currentArray.append(step)
        }

        valueToSend["steps"] = currentArray

//        print("\n\n\n\nHey you mtf:\n\(valueToSend)\n\n\n\n")
        return valueToSend
    }

    func decodeInWatch(_ dataArray: [String: Any?]) -> [Step] {

        var steps: [Step] = []

        guard let data = dataArray["steps"] else { return steps }
//        print("\n\nlook at this:\n\(data)")

        guard let singleData = data as? [[String: Any]] else { return steps }
//        print("\n\nomfg this is happening:\n\(singleData)\n\n\n")

        for stp in singleData {
            guard let text = stp["Texto"] as? String else { return steps }
            guard let time = stp["Tempo"] as? Int else { return steps }

            let newStep = Step(text: text, time: time)
            steps.append(newStep)
        }
        return steps
    }
}

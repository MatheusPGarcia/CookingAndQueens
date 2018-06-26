//
//  ParseWatch.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 25/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class ParseWatch: NSObject {

    func sendToWatch(recipe: Recipes) -> [String:Any?] {

        var valueToSend: [String: Any?] = [:]
        var currentArray = valueToSend["items"] as? [[String: Any]] ?? [[String: Any]]()

        for step in recipe.steps {

            let step: [String: Any] = [
                "Texto": "\(step.text)",
                "Tempo": "\(String(describing: step.time))"
            ]

            currentArray.append(step)
            valueToSend["steps"] = currentArray
        }

        return valueToSend
    }
}

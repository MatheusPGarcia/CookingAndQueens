//
//  Recipes.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Recipes: Codable {

    var name: String
    var ingredients: [String]
    var time: String
    var rendiment: String
    var steps: [Step]

}

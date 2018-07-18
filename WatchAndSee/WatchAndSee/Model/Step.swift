//
//  Step.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 22/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Step {

    var text: String
    var time: Int?
    var order: Int

    init(text: String, time: Int?, order: Int) {

        self.text = text
        self.order = order
        
        guard let timeValue = time else { return }
        self.time = timeValue
    }
}

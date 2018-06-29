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

    init() {
        self.text = ""
        self.time = nil
    }

    init(text: String, time: Int?) {
        self.text = text
        self.time = time
    }

    mutating func setValues(_ text: String, _ time: Int?) {

        self.text = text

        guard let timeValue = time else { return }
        self.time = timeValue
    }
}

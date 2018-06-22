//
//  Step.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 22/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

struct Step: Codable {

    var text: String
    var time: Int?

    init() {
        self.text = ""
        self.time = nil
    }

    mutating func setValues(_ text: String, _ time: Int?) {

        self.text = text

        guard let timeValue = time else { return }
        self.time = timeValue
    }
}

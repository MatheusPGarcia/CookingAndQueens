//
//  InterfaceController.swift
//  WatchAndSee Watch Extension
//
//  Created by Matheus Garcia on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    static var shared = InterfaceController()
    var steps: [Step] = []

    private override init() { }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func setup(data: [String: Any]) {

        let parser = ParseWatch()
        steps = parser.decodeInWatch(data)
        print("Oh mamma mia, I like to use breakpoints, but xuh no, he prefers prints:\n\(steps)")
    }
}

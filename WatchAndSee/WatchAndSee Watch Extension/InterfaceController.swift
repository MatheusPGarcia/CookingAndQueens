//
//  InterfaceController.swift
//  WatchAndSee Watch Extension
//
//  Created by Matheus Garcia on 20/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var steps: [Step] = []

    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {

            if let error = error {
                print("WC Session activation failed with error: \(error.localizedDescription)")
                return
            }

            switch activationState {
            case .activated:
                print("WC Session state is: Activated")
            case .inactive:
                print("WC Session state is: Inactive")
            case .notActivated:
                print("WC Session state is: Not Activated")
            }
        }

        func setupWatchConnectivity() {
            if WCSession.isSupported() {
                let session = WCSession.default
                session.delegate = self
                session.activate()
            }
        }

        func session(_ session: WCSession,
                     didReceiveApplicationContext applicationContext: [String: Any]) {

            DispatchQueue.main.async {
                let parser = ParseWatch()
                self.steps = parser.decodeInWatch(applicationContext)
//                print("Oh mamma mia, I like to use breakpoints, but xuh no, he prefers prints:\n\(self.steps)")

                var context: [String] = []
                for currentStep in self.steps {
                    let text = currentStep.text
                    context.append(text)
                }
                let controllers = [String](repeating: "StepInterfaceController", count: self.steps.count)
                self.presentController(withNames: controllers, contexts: context)
            }
        }

    private override init() { }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        // Configure interface objects here.
        setupWatchConnectivity()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

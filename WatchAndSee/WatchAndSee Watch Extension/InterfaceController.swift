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

    @available(watchOS 2.2, *)
    public func session(_ session: WCSession,
                        activationDidCompleteWith activationState: WCSessionActivationState,
                        error: Error?) {
    }

    var value = 0
    var session: WCSession!

    @IBOutlet var timeLabel: WKInterfaceLabel!

    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        timeLabel.setText("\(value)")
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

    fileprivate func updateLabel (value: Int) {
        timeLabel.setText("\(value)")
    }

    internal func session(_ session: WCSession,
                          didReceiveApplicationContext applicationContext: [String: Any]) {

        let sessionValue = applicationContext["Receita"]
            as? Recipes

        print("this is it:\n\(sessionValue)")
        self.updateLabel(value: 404)

        DispatchQueue.main.async {

            guard let safeValue = sessionValue else { return }

            print("oh man! I can't believe I can fly:\n\(safeValue)")

//            self.value = safeValue
            self.updateLabel(value: 42)
        }
    }

    func sendValue() {

        do {
            let valueToSend = ["Value": value]
            try session.updateApplicationContext(valueToSend)
        } catch {
            print("error")
        }
    }

    @IBAction func subWasPressed() {
        value -= 1
        updateLabel(value: value)
    }

    @IBAction func addWasPressed() {
        value +=  1
        updateLabel(value: value)
    }

    @IBAction func sendToiPhoneWasPressed() {
        sendValue()
    }
}

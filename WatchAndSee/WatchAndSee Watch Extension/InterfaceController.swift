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

// swiftlint:disable all
class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //Dummy Implementation
    }
    
    var session : WCSession!
    var value = 0

    override init() {
        super.init()
        if (WCSession.isSupported()) {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    @IBOutlet var timeLabel: WKInterfaceLabel!

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

    func sendTimer() {

        do {
            let time = ["Time" : value]
            try session.updateApplicationContext(time)
        } catch {
            print("error")
        }
    }

    @IBAction func buttonSendTimerWasPressed() {
        sendTimer()
    }

    @IBAction func subWasPressed() {
        value = value - 1
        timeLabel.setText("\(value)")
    }

    @IBAction func addWasPressed() {
        value = value + 1
        timeLabel.setText("\(value)")
    }

    internal func session(_ session: WCSession,
                          didReceiveApplicationContext applicationContext: [String: Any]) {

        let time = applicationContext["Time"] as? Int
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        DispatchQueue.main.async() {

            guard let timeValue = time else { return }

            self.value = timeValue
            self.timeLabel.setText("\(self.value)")
        }
    }
}
// swiftlint:enable all

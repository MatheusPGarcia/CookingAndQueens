//
//  ViewController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
    }

    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
    }

    @available(iOS 9.3, *)
    public func session(_ session: WCSession,
                        activationDidCompleteWith activationState: WCSessionActivationState,
                        error: Error?) {
    }

    var value = 0
    var session: WCSession!

    @IBOutlet weak var valueLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func updateLabel (value: Int) {
        valueLabel.text = "\(value)"
    }

    internal func session(_ session: WCSession,
                          didReceiveApplicationContext applicationContext: [String: Any]) {

        let sessionValue = applicationContext["Value"] as? Int

        DispatchQueue.main.async {

            guard let safeValue = sessionValue else { return }

            self.value = safeValue
            self.updateLabel(value: self.value)
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

    @IBAction func subWasPressed(_ sender: UIButton) {

        value -= 1
        updateLabel(value: value)
    }

    @IBAction func addWasPressed(_ sender: UIButton) {

        value += 1
        updateLabel(value: value)
    }

    @IBAction func sendToWatchWasPressed(_ sender: UIButton) {
        sendValue()
    }
}

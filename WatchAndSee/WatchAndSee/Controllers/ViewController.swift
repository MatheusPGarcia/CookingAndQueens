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
        //Dummy Implementation
    }

    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        //Dummy Implementation
    }

    @available(iOS 9.3, *)
    public func session(_ session: WCSession,
                        activationDidCompleteWith activationState: WCSessionActivationState,
                        error: Error?) {
        //Dummy Implementation
    }

    var totalTime = 0
    @IBOutlet weak var timeLabel: UILabel!

    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureWCSession()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configureWCSession()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func configureWCSession() {
        session?.delegate = self
        session?.activate()
    }

    internal func session(_ session: WCSession,
                          didReceiveApplicationContext applicationContext: [String: Any]) {

        let time = applicationContext["Time"] as? Int
        //Use this to update the UI instantaneously (otherwise, takes a little while)
        DispatchQueue.main.async() {

            guard let timeValue = time else { return }

            self.totalTime = timeValue
            self.timeLabel.text = "time: \(self.totalTime)"
        }
    }

    @IBAction func sub(_ sender: UIButton) {

        totalTime -= 1
        self.timeLabel.text = "time: \(totalTime)"
    }

    @IBAction func add(_ sender: UIButton) {

        totalTime += 1
        self.timeLabel.text = "time: \(totalTime)"
    }

    @IBAction func enviarWasPressed(_ sender: UIButton) {
        sendValue()
    }

    func sendValue() {

        do {
            let time = ["Time": totalTime]
            try session?.updateApplicationContext(time)
        } catch {
            print("error")
        }
    }
}

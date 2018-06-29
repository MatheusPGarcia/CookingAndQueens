//
//  TimerInterfaceController.swift
//  WatchAndSee Watch Extension
//
//  Created by Matheus Garcia on 29/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import WatchKit

class TimerInterfaceController: WKInterfaceController {

    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var interactiveButton: WKInterfaceButton!

    var timeLeft: Double = 0
    var isRuning: Bool = false

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if let context = context as? String {

            guard let timeDouble = Double(context) else { return }

            // Add one second so the hour can appear completely
            let interval: TimeInterval = timeDouble + 1
            timeLeft = interval

            let time = Date(timeIntervalSinceNow: interval)
            timer.setDate(time)
            WKInterfaceDevice.current().play(.success)

        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func startTimer() {

        if isRuning {
            let buttonTitle = "Start"
            interactiveButton.setTitle(buttonTitle)

            isRuning = false

            let time = Date(timeIntervalSinceNow: timeLeft)
            timer.setDate(time)
            timer.stop()

            return
        }

        let buttonTitle = "Stop"
        interactiveButton.setTitle(buttonTitle)

        let time = Date(timeIntervalSinceNow: timeLeft)
        timer.setDate(time)

        isRuning = true
        timer.start()
    }
}

//
//  StepInterfaceController.swift
//  WatchAndSee Watch Extension
//
//  Created by Matheus Garcia on 29/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import WatchKit

class StepInterfaceController: WKInterfaceController {

    @IBOutlet var stepTextLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if let context = context as? String {
            stepTextLabel.setText(context)
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
}

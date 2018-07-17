//
//  WatchController.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 28/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchController: NSObject {

//    func prepareToSendValue(recipe: Recipe) -> Bool {
//
//        let parseWatch = ParseWatch()
//        let data = parseWatch.sendToWatch(recipe: recipe)
//        return sendValue(data: data)
//    }

    private func sendValue(data: [String: Any?]) -> Bool {

        do {
            let valueToSend = data
            let delegate = AppDelegate()
            return delegate.sendValue(data: valueToSend)
        } catch {
            print("oi: \(error)")
            return false
        }
    }
}

//
//  Recipe.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 11/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct Recipe {

    var name: String
    var reference: CKRecordID

    init(name: String, reference: CKRecordID) {
        self.name = name
        self.reference = reference
    }
}

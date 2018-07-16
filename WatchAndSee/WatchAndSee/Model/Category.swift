//
//  Category.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 26/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct Category {

    var name: String
    var reference: CKRecordID

    init(name: String, reference: CKRecordID) {
        self.name = name
        self.reference = reference
    }
}

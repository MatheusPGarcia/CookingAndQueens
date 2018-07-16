//
//  RecipeImage.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 16/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import CloudKit

struct RecipeImage {

    var image: UIImage?
    var reference: CKRecordID

    init(image: UIImage, reference: CKRecordID) {
        self.image = image
        self.reference = reference
    }
}

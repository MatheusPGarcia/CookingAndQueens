//
//  CKAssetExtension.swift
//  WatchAndSee
//
//  Created by Matheus Garcia on 14/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import CloudKit

extension CKAsset {
    func toUIImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}

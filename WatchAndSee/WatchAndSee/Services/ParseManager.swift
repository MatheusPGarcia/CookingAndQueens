//
//  ResponseParseManager.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 21/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

protocol PersistenceObject {
    associatedtype InternalType
    func parseData(dataDic: [String: Any]) -> InternalType
}

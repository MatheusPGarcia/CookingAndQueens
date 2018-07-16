//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import CloudKit

//Classe Singleton que será responsável pela movimentação no banco de dados
class DatabaseService: NSObject {

    let publicDatabase = CKContainer.default().publicCloudDatabase

    override init() {
        super.init()
    }

    public func fetch (recordType: String,
                       predicate: String?,
                       reference: CKReference?,
                       completion: @escaping ([CKRecord]) -> Void) {

        var predicateValue: NSPredicate

        // Generate the predicate for Query.
        if let predicate = predicate, let reference = reference {
            predicateValue = NSPredicate(format: "\(predicate) = %@", reference)
        } else {
            predicateValue = NSPredicate(value: true)
        }

        // Perform the request
        let query = CKQuery(recordType: recordType, predicate: predicateValue)
        publicDatabase.perform(query, inZoneWith: nil) { (recordReference, error) in

            if let error = error {
                print("ops, something went wrong while trying to query \(recordType):\n\(error)")
                return
            }

            guard let record = recordReference else {
                print("the \(recordType) list is empty")
                return
            }

            completion(record)
        }
    }
}

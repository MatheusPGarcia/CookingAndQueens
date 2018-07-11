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

    public func fetch (predicateName: String, recordType: String) {

        var record = [CKRecord]()

        let predicate = NSPredicate(format: "name = %@", predicateName)

        let query = CKQuery(recordType: recordType, predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil) { (recordReference, error) in

            if let error = error {
                print("ops, something went wrong while trying to query \(recordType):\n\(error)")
                return
            }

            guard let recordList = recordReference else {
                print("the \(recordType) list is empty")
                return
            }

            record = recordList

            print("\nPredicate: \(predicateName)")

            print("was here with the following record:\n\(record)\n")
        }
    }

    //retrieve Data from database
    func createRecipeObject(completion: @escaping (_ response: [Recipes]?) -> Void) {

    }
}

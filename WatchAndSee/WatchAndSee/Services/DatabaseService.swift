//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit
import Firebase

//Classe Singleton que será responsável pela movimentação no banco de dados
class DatabaseService: NSObject {
    static let shared = DatabaseService()

    var ref: DatabaseReference!

    private override init() {
        ref = Database.database().reference()
    }
}

//
//  DatabaseService.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 19/06/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

//Classe Singleton que será responsável pela movimentação no banco de dados
class DatabaseService: NSObject {

    static var shared = DatabaseService()
    let parseRef = ParseManager()
//    var ref: DatabaseReference!

    private override init() {
        super.init()

//        ref = Database.database().reference()
    }

    //retrieve Data from database
    func createRecipeObject(completion: @escaping (_ response: [Recipes]?) -> Void) {

    }
}

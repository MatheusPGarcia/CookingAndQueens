//
//  CategoryParser.swift
//  WatchAndSee
//
//  Created by Larissa Ganaha on 11/07/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class CategoryParser: NSObject, PersistenceObject {
    typealias InternalType = Category
    static var shared = CategoryParser()

    func parseData(dataDic: [String: Any]) -> Category {
        var categoryItem = Category()
        var catElements = [String]()

        if let name = dataDic["Nome"] as? String,
            let elements = dataDic["Itens"] {

            guard let elemDic = elements as? [String: Any] else {
                return Category()
            }
            // swiftlint:disable force_cast

            for element in elemDic {
                catElements.append(element.value as! String)
            }

            categoryItem.name = name
            categoryItem.elements = catElements

            return categoryItem
        }
        print("Incomplete dictionary in parseData object in CategoryParser")
        return Category()
    }

}

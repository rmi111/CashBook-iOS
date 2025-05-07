//
//  Category.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/3/24.
//

import Foundation
import FirebaseFirestore

struct Category: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var icon: String
    var isCustom: Bool = false
    var userId: String?            // Optional for shared categories
    @ServerTimestamp var createdTime: Timestamp?
}

#if DEBUG
//let testsDataCategory  = 
//[
//    Category(name: "Expense"),
//    Category(name: "Gas"),
//    Category(name: "Bill"),
//    Category(name: "Rent"),
//    Category(name: "???"),
//]
#endif

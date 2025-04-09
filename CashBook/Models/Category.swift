//
//  Category.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/3/24.
//

import Foundation
import FirebaseFirestore

struct Category: Codable, Identifiable
{
    @DocumentID var id: String?
    var title: String
    @ServerTimestamp var createdTime: Timestamp?
}

#if DEBUG
let testsDataCategory  = 
[
    Category(title: "Expense"),
    Category(title: "Gas"),
    Category(title: "Bill"),
    Category(title: "Rent"),
    Category(title: "???"),
]
#endif

//
//  Category.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/3/24.
//

import Foundation

struct Category
{
    var id: String = UUID().uuidString
    var title: String
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

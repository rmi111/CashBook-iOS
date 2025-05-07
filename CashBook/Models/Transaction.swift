//
//  Transaction.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 5/5/25.
//

import Foundation


struct Transaction: Codable, Identifiable {
    var id: String = UUID().uuidString
    
    var amount: Double
    var type: String // "income" or "expense"
    var category: Category  // ← embedded directly
    var description: String
    var date: Date
    var isRecurring: Bool
    var recurringInterval: String?
}

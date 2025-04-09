//
//  Business.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/3/24.
//

import Foundation
import FirebaseFirestore

struct Business: Codable, Identifiable
{
    @DocumentID var id: String?
    var collabId: String?
    var userId: String
    var name: String
    @ServerTimestamp var createdTime: Timestamp?
}

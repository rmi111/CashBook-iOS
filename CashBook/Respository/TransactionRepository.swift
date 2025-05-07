//
//  TransactionRepository.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/21/24.
//

import Foundation
import FirebaseFirestore

final class TransactionRepository {
    static let shared = TransactionRepository()
    private init() {}
    
    private let database = Firestore.firestore()

    func addTransaction(_ transaction: Transaction, completion: ((Result<Void, Error>) -> Void)? = nil) {
//        guard let userId = Auth.auth().currentUser?.uid else {
//            completion?(.failure(NSError(domain: "Auth", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
//            return
//        }

        do {
            let docRef = database
                .collection("users")
                .document(UUID().uuidString) // TODO: replace with users
                .collection("transactions")
                .document(transaction.id)

            try docRef.setData(from: transaction) { error in
                if let error = error {
                    completion?(.failure(error))
                } else {
                    completion?(.success(()))
                }
            }
        } catch {
            completion?(.failure(error))
        }
    }
}

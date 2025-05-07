//
//  CategoryViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/6/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Combine

@Observable
class DatabaseViewModel {
    
    enum OperationStatus {
        case notStarted
        case fetching
        case success
        case failed
    }
    
    private(set) var fetchStatus: OperationStatus = .notStarted

    private var categoryListener: ListenerRegistration?

    // Local categories (default categories in app + user-specific categories)
    var categories: [Category] = CategoryRepository.shared.categories

    // Load categories with real-time listener
    func loadCategories(user: User?) {
        fetchStatus = .fetching

        // Remove any existing listener before adding a new one
        categoryListener?.remove()
        
        let userId = user?.uid ?? "anonymous"
        
        categoryListener = CategoryRepository.shared.fetchCategoriesWithListener(for: userId) { [weak self] (categories, error) in
            guard let self = self else { return }

            if let error = error {
                self.fetchStatus = .failed
                print("Error fetching categories: \(error.localizedDescription)")
                return
            }

            self.fetchStatus = .success
            if let categories = categories {
                self.categories = categories
            }
        }
    }
}


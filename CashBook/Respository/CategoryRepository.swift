//
//  CategoryRepository.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/22/24.
//

import Foundation
import FirebaseFirestore


class CategoryRepository {
    static let shared = CategoryRepository()

    var categories: [Category] = [
        Category(name: "Groceries", icon: "cart.fill"),
        Category(name: "Transport", icon: "car.fill"),
        Category(name: "Food", icon: "fork.knife"),
        Category(name: "Health", icon: "heart.fill"),
        Category(name: "Entertainment", icon: "gamecontroller.fill"),
        Category(name: "Travel", icon: "airplane"),
        Category(name: "Shopping", icon: "bag.fill"),
        Category(name: "Bills", icon: "creditcard.fill"),
        Category(name: "Education", icon: "book.fill"),
        Category(name: "Fitness", icon: "figure.walk"),
        Category(name: "Savings", icon: "banknote.fill"),
        Category(name: "Investments", icon: "chart.bar.xaxis"),
        Category(name: "Clothes", icon: "tshirt.fill"),
        Category(name: "Home", icon: "house.fill"),
        Category(name: "Gifts", icon: "gift.fill"),
        Category(name: "Phone", icon: "iphone.gen2"),
        Category(name: "Utilities", icon: "bolt.fill"),
        Category(name: "Insurance", icon: "shield.fill"),
        Category(name: "Subscriptions", icon: "tv.fill"),
        Category(name: "Baby", icon: "figure.2.and.child.holdinghands"),
        Category(name: "Beauty", icon: "sparkles"),
        Category(name: "Charity", icon: "hands.sparkles.fill"),
        Category(name: "Pets", icon: "pawprint.fill"),
        Category(name: "Rent", icon: "building.columns.fill"),
        Category(name: "Water", icon: "drop.fill"),
        Category(name: "Cleaning", icon: "broom"),
        Category(name: "Repair", icon: "wrench.fill"),
        Category(name: "Parking", icon: "parkingsign.circle.fill"),
        Category(name: "Laundry", icon: "washer.fill"),
        Category(name: "Books", icon: "books.vertical.fill"),
        Category(name: "Internet", icon: "wifi"),
        Category(name: "Gaming", icon: "gamecontroller"),
        Category(name: "Camera", icon: "camera.fill"),
        Category(name: "Music", icon: "music.note"),
        Category(name: "Tools", icon: "hammer.fill"),
        Category(name: "Tickets", icon: "ticket.fill"),
        Category(name: "Hospital", icon: "cross.fill"),
        Category(name: "Fuel", icon: "fuelpump.fill"),
        Category(name: "Donations", icon: "gift.circle.fill"),
        Category(name: "Coffee", icon: "cup.and.saucer.fill"),
        Category(name: "Snacks", icon: "leaf.fill"),
        Category(name: "Doctor", icon: "stethoscope"),
        Category(name: "Salon", icon: "scissors"),
        Category(name: "Debt", icon: "exclamationmark.circle.fill"),
        Category(name: "Income", icon: "dollarsign.circle.fill"),
        Category(name: "Bonus", icon: "star.circle.fill"),
        Category(name: "Freelance", icon: "laptopcomputer"),
        Category(name: "Salary", icon: "briefcase.fill"),
        Category(name: "Other", icon: "ellipsis.circle")
    ]

    public init() {}

    // Add a custom category to Firestore for a specific user
    func addCategory(_ category: Category, for userId: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var categoryWithUserId = category
        categoryWithUserId.userId = userId // Assign userId to category if not already set
        do {
            _ = try db.collection("users")
                .document(userId)
                .collection("categories")
                .addDocument(from: categoryWithUserId, completion: completion)
        } catch {
            completion(error)
        }
    }

    // Fetch categories for a specific user (combines local and Firestore data)
    // Fetch categories for a specific user (with a real-time listener)
        func fetchCategoriesWithListener(for userId: String, completion: @escaping ([Category]?, Error?) -> Void) -> ListenerRegistration {
            let db = Firestore.firestore()

            // Listen to changes in the user's categories collection
            return db.collection("users")
                .document(userId)
                .collection("categories")
                .addSnapshotListener { snapshot, error in
                    if let error = error {
                        completion(nil, error)
                        return
                    }

                    // Retrieve custom categories from Firestore
                    let firestoreCategories = snapshot?.documents.compactMap {
                        try? $0.data(as: Category.self)
                    } ?? []

                    // Combine the default categories with the user-specific categories
                    var combinedCategories = self.categories // Default categories
                    combinedCategories.append(contentsOf: firestoreCategories)

                    completion(combinedCategories, nil)
                }
        }
}

//class CategoryRepository: ObservableObject
//{
//    let db = Firestore.firestore()
//    
//    @Published var categories = [Category]()
//    
//    init(){
//        loadData()
//    }
//    
//    func loadData()
//    {
//        //db.collection("category").order(by: "createdTime").addSnapshotListener{(querySnapshot, error) in
////        db.collection("category").addSnapshotListener{(querySnapshot, error) in
////            if let querySnapshot = querySnapshot
////            {
////                self.categories = querySnapshot.documents.compactMap
////                {
////                    document in
////                    print(document)
////                    do{
////                        return try document.data(as: Category.self)
////                    }
////                    catch
////                    {
////                        print(error)
////                    }
////                    
////                    return nil
////                }
////            }
////        };
//    }
//    
//    func addCategory(category: Category)
//    {
////        do{
////            let _ = try db.collection("category").addDocument(from: category)
////        }
////        catch{
////            fatalError("Unable to encode tasks: \(error.localizedDescription)")
////        }
//    }
//    
//    func updateCategory(category: Category)
//    {
////        if let id = category.id
////        {
////            do {
////                try db.collection("category").document(id).setData(from: category)
////                
////            }
////            catch{
////                fatalError("Unable to update: \(error.localizedDescription)")
////            }
////        }
//    }
//}

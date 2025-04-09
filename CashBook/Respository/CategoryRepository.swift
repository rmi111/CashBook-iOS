//
//  CategoryRepository.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/22/24.
//

import Foundation
import FirebaseFirestore

class CategoryRepository: ObservableObject
{
    let db = Firestore.firestore()
    
    @Published var categories = [Category]()
    
    init(){
        loadData()
    }
    
    func loadData()
    {
        //db.collection("category").order(by: "createdTime").addSnapshotListener{(querySnapshot, error) in
        db.collection("category").addSnapshotListener{(querySnapshot, error) in
            if let querySnapshot = querySnapshot
            {
                self.categories = querySnapshot.documents.compactMap
                {
                    document in
                    print(document)
                    do{
                        return try document.data(as: Category.self)
                    }
                    catch
                    {
                        print(error)
                    }
                    
                    return nil
                }
            }
        };
    }
    
    func addCategory(category: Category)
    {
        do{
            let _ = try db.collection("category").addDocument(from: category)
        }
        catch{
            fatalError("Unable to encode tasks: \(error.localizedDescription)")
        }
    }
    
    func updateCategory(category: Category)
    {
        if let id = category.id
        {
            do {
                try db.collection("category").document(id).setData(from: category)
                
            }
            catch{
                fatalError("Unable to update: \(error.localizedDescription)")
            }
        }
    }
}

//
//  BookRepository.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/3/24.
//

import Foundation
import FirebaseFirestore

class BookRepository: ObservableObject
{
    let db = Firestore.firestore()
    
    @Published var books = [Book]()
    
    init(){
        loadData()
    }
    
    func loadData()
    {
        //db.collection("category").order(by: "createdTime").addSnapshotListener{(querySnapshot, error) in
        db.collection("books").addSnapshotListener{(querySnapshot, error) in
            if let querySnapshot = querySnapshot
            {
                self.books = querySnapshot.documents.compactMap
                {
                    document in
                    print(document)
                    do{
                        return try document.data(as: Book.self)
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
    
    func addBook(book: Book)
    {
        do{
            let _ = try db.collection("books").addDocument(from: book)
        }
        catch{
            fatalError("Unable to encode tasks: \(error.localizedDescription)")
        }
    }
    
    func updateBook(book: Book)
    {
        if let id = book.id
        {
            do {
                try db.collection("books").document(id).setData(from: book)
                
            }
            catch{
                fatalError("Unable to update: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteBook(book: Book)
    {
        if let id = book.id
        {
            db.collection("books").document(id).delete()
        }
    }
}

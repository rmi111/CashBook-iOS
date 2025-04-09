//
//  BookListViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/3/24.
//

import Combine
import Foundation

class BookListViewModel: ObservableObject
{
    @Published var bookRepository = BookRepository()
    @Published var bookItemViewModel = [BookCellViewModel]()
    
    private var cancelleable = Set<AnyCancellable>()
    
    init()
    {
        bookRepository.$books.map 
        {
            book in
            book.map
            {
                book in
                BookCellViewModel(book: book)
            }
        }
        .assign(to: \.bookItemViewModel, on: self)
        .store(in: &cancelleable)
    }
    
    func addCategory(book: Book)
    {
        bookRepository.addBook(book: book)
    }
    
    func updateBook(book: Book)
    {
        bookRepository.updateBook(book: book)
    }
    
    func deleteBook(book: Book)
    {
        bookRepository.deleteBook(book: book)
    }
}

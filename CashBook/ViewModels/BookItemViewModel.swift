//
//  BookItemViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/3/24.
//

import Combine
import Foundation

enum FetchStatus{
    case fetching
    case sucess
    case failed(error: Error)
}

enum Status
{
    case loading
    case success
    case canceled
    case failed(error: Error)
}

@Observable
class BookCellViewModel
{
    var book: Book
    var selected: Book?
    
    var id = ""
    private var cancellable = Set<AnyCancellable>()
    
    init(book: Book)
    {
        self.book = book
        
        if let id = self.book.id
        {
            self.id = id
        }
        
//            book in
//            book.id
//        }.assign(to: \.id, on: self)
//         .store(in: &cancellable)
    }
}

//
//  CategoryViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/6/24.
//

import Foundation
import Combine

class CategoryCellViewModel: ObservableObject, Identifiable
{
    @Published var category: Category
    @Published var selected: Category?
    
    var id = ""
    private var cancellable = Set<AnyCancellable>()
    
    init(category: Category)
    {
        self.category = category
       // self.selected = selected
        
        $category.map {
            category in
            category.id
        }.assign(to: \.id, on: self)
         .store(in: &cancellable)
    }
}

//
//  CategoryListViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/6/24.
//

import Foundation

class CategoryListViewModel: ObservableObject
{
    @Published var categoryItemViewModel = [CategoryCellViewModel]()
    
    init(){
        self.categoryItemViewModel = testsDataCategory.map {
                category in
            CategoryCellViewModel(category: category)
        }
    }
}

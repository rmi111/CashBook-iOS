//
//  CategoryListViewModel.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/6/24.
//

import Foundation
import Combine

class CategoryListViewModel: ObservableObject
{
  //  @Published var categoryRespository = CategoryRepository()
   // @Published var categoryItemViewModel = [CategoryCellViewModel]()
    
    private var cancelleable = Set<AnyCancellable>()
    
    init(){
//        categoryRespository.$categories.map {
//            categories in
//            categories.map{
//                category in
//                CategoryCellViewModel(category: category)
//            }
//        }
//        .assign(to: \.categoryItemViewModel, on: self)
//        .store(in: &cancelleable)
//        self.categoryItemViewModel = testsDataCategory.map {
//                category in
//            CategoryCellViewModel(category: category)
//        }
    }
    
    func addCategory(category: Category){
        //categoryRespository.addCategory(category: category)
    }
}

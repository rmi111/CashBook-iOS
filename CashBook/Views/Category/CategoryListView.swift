//
//  CategoryListView.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/6/24.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var vm = CategoryListViewModel()
    @State var selected: Category?
    
    var body: some View {
        VStack(alignment: .leading){
            List{
                ForEach(vm.categoryItemViewModel){
                    item in
                    CategoryCell(vm: item, selected: $selected)
                      
                }
            }
        }
    }
}

struct CategoryCell: View{
    
    @ObservedObject var vm: CategoryCellViewModel
    @Binding var selected: Category?
    
    var body: some View{
        HStack{
            Image(systemName: (selected != nil && selected?.id == vm.selected?.id) ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width:20, height: 20)
            Text(vm.category.title)
        }
        .onTapGesture {
            selected = vm.category
            vm.selected = selected
        }
    }
}

#Preview {
    CategoryListView()
}

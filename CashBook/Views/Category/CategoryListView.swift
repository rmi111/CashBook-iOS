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
//            List{
//                ForEach(vm.categoryItemViewModel){
//                    item in
//                    CategoryCell(vm: item, selected: $selected)
//                      
//                }
//            }
        }
    }
}

struct AddCustomCategoryView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var selectedIcon: String? = nil

    var onSave: ((Category) -> Void)?

    var body: some View {
  
            VStack(spacing: 20) {
                TextField("Category Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Text("Choose Icon").font(.headline)

//                ScrollView {
//                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 16) {
//                        ForEach(symbolOptions, id: \.self) { symbol in
//                            Button(action: {
//                                selectedIcon = symbol
//                            }) {
//                                Image(systemName: symbol)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 30, height: 30)
//                                    .padding()
//                                    .background(selectedIcon == symbol ? Color.accentColor.opacity(0.3) : Color.gray.opacity(0.1))
//                                    .clipShape(Circle())
//                            }
//                        }
//                    }.padding(.horizontal)
//                }

                Button("Save Category") {
                 //   guard let icon = selectedIcon, !name.isEmpty else { return }
                  //  let newCategory = Category(name: name, iconName: icon, isCustom: true)
                   // onSave?(newCategory)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)

                Spacer()
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
        }
   
}


struct CategoryCell: View{
    
   // @ObservedObject var vm: CategoryCellViewModel
    @Binding var selected: Category?
    
    var body: some View{
        HStack{
            Image(systemName: "circle")
                .resizable()
                .frame(width:20, height: 20)
           // Text(vm.category.name)
        }
        .onTapGesture {
//            selected = vm.category
//            vm.selected = selected
        }
    }
}

#Preview {
    CategoryListView()
}

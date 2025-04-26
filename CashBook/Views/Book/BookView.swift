//
//  BookView.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/10/25.
//

import SwiftUI

struct BookView: View {
    @Binding var isShowingBottomSheet: Bool
    
    var body: some View {
       
        VStack(spacing: 0){
                HStack(alignment: .bottom){
                    
                    Button(action: {
                        isShowingBottomSheet.toggle()
                    }){
                        HStack{
                            Image(systemName: "person")
                            Text("Hello")
                                .foregroundColor(.primary)
                            Image(systemName: "chevron.down")
                        }
                    }.foregroundColor(.secondary)
                        .padding(16)
                        
                    
                    Spacer()
                    
                }.frame(maxWidth: .infinity)
                .background(Color("ContainerColor"))
                
                
                SearchField()
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                
                HStack{
                    Text("Your Books")
                        .customFont(.semiBold, 24)
                    
                    Spacer()
                    IconButton(label: "Add Book"){
                        
                    }
                } .padding(.horizontal, 24)
                    .padding(.vertical, 8)
            
//            Image("AppIcon")
//                .resizable()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.red)
//            
                List{
                    ForEach(1..<10){ i in
                        BookItemView()
                            .frame(height: 75)
                            .padding(10)
                            .listRowBackground(
                                           Color(.clear)
                                           .clipped()
                                           .cornerRadius(10))
                            .cornerRadius(10)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())

                    }
                }.listStyle(.plain)
                    .listRowSpacing(8)
                    .scrollIndicators(.hidden)
                    .contentMargins(.horizontal, 5, for: .scrollContent)
                    .background(Color.clear)
                    .padding(.horizontal, 4)
                
               // Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)

        
    }
}

#Preview {
    BookView(isShowingBottomSheet: .constant(false))
}

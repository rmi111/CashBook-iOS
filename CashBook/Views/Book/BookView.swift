//
//  BookView.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/10/25.
//

import SwiftUI

struct BookView: View {
    var body: some View {
       
            VStack{
                HStack(alignment: .bottom){
                    
                    Button(action: {
                        
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
                
               
                List{
                    ForEach(1..<10){ i in
                        BookItemView()
                            .frame(height: 65)
                            .padding(0)
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
                    .contentMargins(.horizontal, 5, for: .scrollContent)
                    .background(Color.clear)
                    .padding(.horizontal, 4)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundColor"))

        
    }
}

#Preview {
    BookView()
}

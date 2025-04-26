//
//  BookItemView.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 4/10/25.
//

import SwiftUI

struct BookItemView: View {
    var body: some View {
        HStack{
            Image("book")
              .resizable()
              .frame(width: 25, height: 25)
              .foregroundColor(.blue)
              .padding(8)
              .background(Color("IconColor"))
              .clipShape(Circle())
            
            VStack(alignment:.leading)
            {
                Text("January Expenses")
                    .customFont(.bold, 14)
                    .foregroundStyle(Color("FontColor"))
                
                Text("Updated on Jan 21 2024")
                    .customFont(.medium, 12)
                    .foregroundStyle(.gray)
                    
            }
            .padding(.horizontal, 8)
            
            Spacer()
            
            Text("10000")
                .customFont(.bold, 14)
                .foregroundStyle(Color("Green"))
        }
        .frame(height: 70)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color("RowColor"))
        .cornerRadius(8)
    }
}

#Preview {
    HStack{
        BookItemView().padding(4)
           
    } .background(.black)
}

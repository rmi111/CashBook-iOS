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
              .frame(width: 15, height: 15)
              .foregroundColor(.blue)
              .padding(6)
              .background(Color("IconColor"))
              .clipShape(Circle())
            
            VStack(alignment:.leading)
            {
                Text("January Expenses")
                    .customFont(.bold, 13)
                
                Text("Updated on Jan 21 2024")
                    .customFont(.regular, 10)
                    .foregroundStyle(.gray)
                    
            }
            Spacer()
            
            Text("10000")
                .customFont(.regular, 12)
                .foregroundStyle(.green)
        }
        .frame(height: 70)
        .padding(8)
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    HStack{
        BookItemView().padding(4)
           
    } .background(.black)
}

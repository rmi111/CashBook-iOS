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
            Image("")
                .frame(width: 20, height: 20)
            
            VStack(alignment:.leading)
            {
                Text("January Expenses")
                    .customFont()
                
                Text("Updated on Jan 21 2024")
                    .customFont()
            }
            Spacer()
            
            Text("10000")
        }
        .frame(height: 50)
        .padding(16)
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    HStack{
        BookItemView().padding(4)
           
    } .background(.black)
}

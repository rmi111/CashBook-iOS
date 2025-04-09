//
//  Input.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 3/24/25.
//
import SwiftUI

struct Input: View{
    @State var text: String = ""
    
    var body: some View {
        HStack{
            TextField("Email", text: $text)
        }.frame(height: 60)
            .overlay{
                RoundedRectangle(cornerRadius: 15)
                    .inset(by: 0.5)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            }
    }
    
}


#Preview
{
    Input()
}

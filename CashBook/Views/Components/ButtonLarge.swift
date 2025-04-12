//
//  ButtonLarge.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/2/24.
//

import SwiftUI

struct IconButton: View {
    
    var label: String
    var background: Color = .blue
    var textColor: Color = .white.opacity(0.9)
    var action: (() -> ())
    
    let cornorRadius: CGFloat = 24
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                Image(systemName: "plus")
                
                Spacer(minLength: 20)
                    .frame(width:20)
                
                Text(label)
                    .customFont(.semiBold, 16)
                    //.font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                
                Spacer(minLength: 20)
                    .frame(width:20)
            }
            .frame(height: 32)
            .foregroundColor(textColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: cornorRadius)
                    .stroke(.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .background(background)
        .cornerRadius(cornorRadius)
    }
}

#Preview {
    IconButton(label: "Add New Book", action: {})
}

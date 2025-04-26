//
//  Input.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 3/24/25.
//
import SwiftUI

struct SearchField: View{
    @State var text: String = ""
    
    var body: some View {
        HStack(spacing: 8){
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $text)
                .font(.custom("Poppins-Thin", size: 12))
            
            Divider().frame(width: 1)
                .padding(.vertical, 12)
            
            Image(systemName: "line.3.horizontal.decrease")
        }.frame(height: 50)
            .padding(.horizontal, 16)
            .background(Color("Primary"))
            .cornerRadius(10)
            .foregroundStyle(Color("Secondary"))

    }
}

struct Input: View{
    @State var text: String = ""
    
    var body: some View {
        HStack(spacing: 8){
            Image(systemName: "magnifyingglass")
            
            TextField("Email", text: $text)
                .font(.custom("Poppins-Thin", size: 12))
            
            Divider().frame(width: 1)
                .padding(.vertical, 12)
            
            Image(systemName: "line.3.horizontal.decrease")
        }.frame(height: 50)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(10)
            .foregroundStyle(.gray)

    }
}

struct CustomSecureField: View {
    @Binding private var text: String
    @State private var isSecured = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .font(.custom("Poppins-Thin", size: 12))
                } else {
                    TextField(title, text: $text)
                        .font(.custom("Poppins-Thin", size: 12))
                }
            }
            .padding(.trailing, 32)

            Button {
                isSecured.toggle()
            } label: {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
        .frame(height: 40)
        .padding(.horizontal, 16)
        .background(.white)
        .cornerRadius(12)
    }
}


struct SecureTextField: View{
    @State var text: String = ""
    
    var body: some View {
        HStack(spacing: 8){
            Image(systemName: "magnifyingglass")
            
            TextField("Email", text: $text)
                .font(.custom("Poppins-Thin", size: 10))
            
            Divider().frame(width: 1)
                .padding(.vertical, 12)
            
            Image(systemName: "line.3.horizontal.decrease")
        }.frame(height: 50)
            .padding(.horizontal, 16)
            .background(Color.white)
            .cornerRadius(10)
            .foregroundStyle(.gray)
    }
}



#Preview
{
    
    
    HStack{
        CustomSecureField("Enter your password", text: .constant(""))
        //SearchField()
    }
    .padding(8)
    .background(Color.black)
   
}

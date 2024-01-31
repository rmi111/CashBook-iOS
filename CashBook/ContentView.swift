//
//  ContentView.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .house
    @State private var selection: String?
    
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
//        ZStack{
//            VStack{
//                TabView(selection: $selectedTab){
//                    ForEach(Tab.allCases, id: \.rawValue){
//                        tab in
//                        HStack{
//                            Image(systemName: tab.rawValue)
//                            Text("\(tab.rawValue.capitalized)")
//                                .bold()
//                                .animation(nil, value: selectedTab)
//                        }.tag(tab)
//                    }
//                }
//            }
//            VStack{
//                Spacer()
//                CustomTabBar(selectedTab: $selectedTab)
//            }
//        }.ignoresSafeArea()
       
        NavigationStack{
            VStack{
                Button("Click"){
                    
                }
                DropDownView(hint: "Select", options: ["Youtube", "Insta", "X", "Snap"],anchor:.bottom, selection: $selection)
                
                DropDownView(hint: "Select", options: ["Youtube", "Insta", "X", "Snap"],anchor:.top, selection: $selection)
                
                Button("Click"){
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

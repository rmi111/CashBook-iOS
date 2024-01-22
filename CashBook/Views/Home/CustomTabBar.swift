//
//  CustomTabBar.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI

enum Tab: String, CaseIterable
{
    case house
    case message
    case person
    case leaf
    case gearshape
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String
    {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View 
    {
        VStack{
            HStack
            {
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    Spacer()
                    VStack{
                        
                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                            .foregroundStyle(.white)
                            .font(.system(size: 22))
                            .onTapGesture{
                                withAnimation(.easeIn(duration: 0.1)){
                                    selectedTab = tab
                                }
                            }
                        if(selectedTab == tab){
                            Circle().frame(width:4)
                                .padding(4)
                                .foregroundColor(.white)
                        }
                      
                    }
                    Spacer()
                }
            }.frame(width: nil, height: 100)
                //.background(.thinMaterial)
                .background(Color(hex:0x8799fd))
                .cornerRadius(30)
                .padding(0)
            
        }.padding(0)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}

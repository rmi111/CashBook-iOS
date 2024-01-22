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
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                    Spacer()
                }
            }.frame(width: nil, height: 60)
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(0)
        }.padding(0)
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.house))
}

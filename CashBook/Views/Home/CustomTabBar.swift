//
//  CustomTabBar.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI

enum Tab: String, CaseIterable
{
    case home
    case message
    case gearshape
    
    var systemImage: String{
        switch self{
        case .home: return "house"
        case .message: return "message"
        case .gearshape: return "person"
        //case .gearshape: return "gearshap"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    private var fillImage: String
    {
        selectedTab.systemImage + ".fill"
    }
    
    var body: some View 
    {
      
            HStack
            {
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    Spacer()
                    VStack{
                        
                        Image(systemName: selectedTab == tab ? fillImage : tab.systemImage)
                            .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                            .foregroundStyle(.white)
                            .font(.system(size: 18))

                        if(selectedTab == tab){
                            Circle().frame(width:4)
                                .padding(4)
                                .foregroundColor(.white)
                        }
                      
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture{
                        withAnimation(.easeIn(duration: 0.04)){
                            selectedTab = tab
                        }
                    }
                    
                    Spacer()
                }
            }
                //.background(.thinMaterial)
            .frame(height: 90)
            .padding(0)
            .background(Color("ContainerColor"))
               // .cornerRadius(30)
              
               // .frame(width: nil, height: 100)
            
        
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}

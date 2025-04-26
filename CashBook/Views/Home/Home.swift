//
//  Home.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI


struct Home: View {
    @State private var activeTab: Tab = .home
    @State var isShowingBottomSheet = false
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {

                    ZStack{
        
                        VStack(spacing: 0){
                            TabView(selection: $activeTab){
                                BookView(isShowingBottomSheet: $isShowingBottomSheet).tag(Tab.home)
                                
                                Text("Transaction").tag(Tab.message)
                                
                                Text("Settings").tag(Tab.gearshape)
                            }
                            
                            Divider()
                            
                            CustomTabBar(selectedTab: $activeTab)
                        }
                            
                            .frame(maxWidth:.infinity,maxHeight:.infinity)
                            .padding(0)
                            .edgesIgnoringSafeArea(.all)
        
                                BottomSheet(isShowing: $isShowingBottomSheet, content: BottomSheetType.offline.view())
                    }
       
    }
}

#Preview {
    Home()
}

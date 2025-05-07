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
    @Environment(DatabaseViewModel.self) var viewModel
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {

                    ZStack{
        
                        VStack(spacing: 0){
                            if viewModel.fetchStatus == .fetching {
                                ProgressView("Loading Categories...")
                            }
//                                      } else {
//                                          // Your main content with viewModel.categories
//                                      }
                            
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
        
                            //BottomSheet(isShowing: $isShowingBottomSheet, content: BottomSheetType.offline.view())
                    }.bottomSheet(isShowing: $isShowingBottomSheet) {
                        OfflineBottomSheet()
                    }
                    .task {
                        // if let user = Auth.auth().currentUser {
                        self.viewModel.loadCategories(user: nil)
                        //}
                    }
       
    }
}

#Preview {
    Home()
}

//
//  Home.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/22/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: .constant(1))
            {
                Color(.red)
                    .ignoresSafeArea()
                    .tag("square.and.arrow.up.circle.fill")
                
                Color(.cyan)
                    .ignoresSafeArea()
                    .tag("square.and.arrow.up.circle.fill")
            }
            
        }//.ignoreSafeArea()
     
    }
}

#Preview {
    Home()
}

//
//  OnlineBottomSheet.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/2/24.
//

import SwiftUI

struct OnlineBottomSheet: View{
    
    let buttonHeight: CGFloat = 55
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack {
                Text("Go Online")
                    .foregroundColor(.black.opacity(0.9))
                    .font(.system(size: 20, weight: .bold))

                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 4)
            
            Text("Are you want to go online? If yes then you can go online or also you can snooz availability or stay offline if not.")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black.opacity(0.7))
                .padding(.bottom, 24)
            
            ButtonLarge(label: "Snooz Availability", action: {
                // Action will be here
            })
            .frame(height: buttonHeight)
            
            ButtonLarge(label: "Go Online", action: {
                // Action will be here
            })
            .frame(height: buttonHeight)
            .padding(.vertical, 2)
            
            ButtonLarge(label: "Stay Offline", background: .pink.opacity(0.95), textColor: .white, action: {
                // Action will be here
            })
            .frame(height: buttonHeight)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    OnlineBottomSheet()
}

//
//  BottomSheet.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/2/24.
//

import SwiftUI

enum BottomSheetType: Int {
    case online = 0
    case offline
    
    func view() -> AnyView {
        switch self {
        case .online:
            return AnyView(OnlineBottomSheet())
        case .offline:
            return AnyView(OfflineBottomSheet())
        }
    }
}

struct BottomSheet: View {

    @Binding var isShowing: Bool
    var content: AnyView
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .padding(.bottom, 42)
                    .transition(.move(edge: .bottom))
                    .background(
                        Color(uiColor: .white)
                    )
                    .cornerRadius(16, corners: [.topLeft, .topRight])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    BottomSheet(isShowing: .constant(true), content:BottomSheetType.offline.view() )
}

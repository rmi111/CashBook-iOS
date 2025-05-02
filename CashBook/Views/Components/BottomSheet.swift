//
//  BottomSheet.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 2/2/24.
//

import SwiftUI


struct BottomSheet<Content: View>: View {
    @Binding var isShowing: Bool
    let content: () -> Content

    init(isShowing: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isShowing = isShowing
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.0)
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                content()
                    .padding(.bottom, 42)
                    .background(Color.white)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .transition(.move(edge: .bottom))
                
               
            }
        }
        .animation(.snappy(duration: 0.4), value: isShowing)
        .ignoresSafeArea()
    }
}

//
//
//enum BottomSheetType: Int {
//    case online = 0
//    case offline
//    
//    func view() -> AnyView {
//        switch self {
//        case .online:
//            return AnyView(OnlineBottomSheet())
//        case .offline:
//            return AnyView(OfflineBottomSheet())
//        }
//    }
//}
//
//struct BottomSheet: View {
//
//    @Binding var isShowing: Bool
//    var content: AnyView
//    
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            if (isShowing) {
//                Color.black
//                    .opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        isShowing.toggle()
//                    }
//                content
//                    .padding(.bottom, 42)
//                    .transition(.move(edge: .bottom))
//                    .background(
//                        Color(uiColor: .white)
//                    )
//                    .cornerRadius(16, corners: [.topLeft, .topRight])
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//        .ignoresSafeArea()
//        .animation(.easeInOut, value: isShowing)
//    }
//}

#Preview {
  //  BottomSheet(isShowing: .constant(true), content:BottomSheetType.offline.view() )
}

//
//  Extensions.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 1/23/24.
//

import Foundation
import SwiftUI

extension Color
{
    init(hex: Int, opacity: Double = 1)
    {
        self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xff) / 255,
                green: Double((hex >> 8) & 0xff) / 255,
                blue: Double((hex >> 0) & 0xff) / 255,
                opacity: opacity
            )
        
    }
}

enum FontWeight {
    case light
    case regular
    case medium
    case semiBold
    case bold
    case black
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .light:
            Font.custom("Poppins-Light", size: size)
        case .regular:
            Font.custom("Poppins-Regular", size: size)
        case .medium:
            Font.custom("Poppins-Medium", size: size)
        case .semiBold:
            Font.custom("Poppins-SemiBold", size: size)
        case .bold:
            Font.custom("Poppins-Bold", size: size)
        case .black:
            Font.custom("Poppins-Black", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}


extension TextField {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> TextField {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16)) as! TextField
    }
}


extension View {
    func bottomSheet<SheetContent: View>(
        isShowing: Binding<Bool>,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self
            .overlay(
                BottomSheet(isShowing: isShowing, content: content)
            )
    }
}

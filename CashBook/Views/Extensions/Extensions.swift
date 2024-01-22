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

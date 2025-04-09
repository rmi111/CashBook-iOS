//
//  Buttons.swift
//  CashBook
//
//  Created by MD Aminuzzaman on 3/24/25.
//

import SwiftUI

struct BulgingButtonShape: Shape {
    var bulgeAmount: CGFloat  // Dynamic bulge

    var animatableData: CGFloat {
        get { bulgeAmount }
        set { bulgeAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = rect.height / 6
        let bulge = rect.height * bulgeAmount  // Controls bulge dynamically

        path.move(to: CGPoint(x: cornerRadius, y: 0))

        // Top Curve (bulging effect)
        path.addQuadCurve(
            to: CGPoint(x: rect.width - cornerRadius, y: 0),
            control: CGPoint(x: rect.width / 2, y: -bulge)
        )

        // Top-right Corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        // Right Side
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))

        // Bottom-right Corner
        path.addArc(center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        // Bottom Curve (bulging effect)
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: rect.height),
            control: CGPoint(x: rect.width / 2, y: rect.height + bulge)
        )

        // Bottom-left Corner
        path.addArc(center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)

        // Left Side
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))

        // Top-left Corner
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)

        return path
    }
}


struct AnimatedBulgingButton: View {
    var title: String
    var action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 15)
                .frame(height: 60)
                .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            BulgingButtonShape(bulgeAmount: isPressed ? 0.2 : 0.1) // Animate bulge
                .fill(Color.blue)
                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}


//struct BulgingButtonShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        let cornerRadius: CGFloat = rect.height / 6
//        let bulgeAmount: CGFloat = rect.height * 0.12 // Controls how much it bulges
//
//        path.move(to: CGPoint(x: cornerRadius, y: 0)) // Start from top-left curve
//        
//        // Top Curve
//        path.addQuadCurve(
//            to: CGPoint(x: rect.width - cornerRadius, y: 0),
//            control: CGPoint(x: rect.width / 2, y: -bulgeAmount)
//        )
//
//        // Top-right Corner
//        path.addArc(
//            center: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
//            radius: cornerRadius,
//            startAngle: Angle(degrees: -90),
//            endAngle: Angle(degrees: 0),
//            clockwise: false
//        )
//
//        // Right Side
//        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
//
//        // Bottom-right Corner
//        path.addArc(
//            center: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
//            radius: cornerRadius,
//            startAngle: Angle(degrees: 0),
//            endAngle: Angle(degrees: 90),
//            clockwise: false
//        )
//
//        // Bottom Curve
//        path.addQuadCurve(
//            to: CGPoint(x: cornerRadius, y: rect.height),
//            control: CGPoint(x: rect.width / 2, y: rect.height + bulgeAmount)
//        )
//
//        // Bottom-left Corner
//        path.addArc(
//            center: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
//            radius: cornerRadius,
//            startAngle: Angle(degrees: 90),
//            endAngle: Angle(degrees: 180),
//            clockwise: false
//        )
//
//        // Left Side
//        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
//
//        // Top-left Corner
//        path.addArc(
//            center: CGPoint(x: cornerRadius, y: cornerRadius),
//            radius: cornerRadius,
//            startAngle: Angle(degrees: 180),
//            endAngle: Angle(degrees: 270),
//            clockwise: false
//        )
//
//        return path
//    }
//}

//struct BulgingButton: View {
//    var title: String
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding(.horizontal, 40)
//                .padding(.vertical, 15)
//                .frame(height: 60)
//                
//                .shadow(radius: 5)
//        }
//        .frame(width: 300)
//        .background(BulgingButtonShape().fill(Color.blue))
//        
//    }
//}


#Preview{
    AnimatedBulgingButton(title: "Press Me") {
        print("Animated button tapped!")
    }
    .padding()
}

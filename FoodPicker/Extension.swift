//
//  Extension.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/18.
//

import SwiftUI

extension View{
    func mainButtonStyle(shape: ButtonBorderShape = .capsule) -> some View{
        buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
    }
    func roundedRectBackground(radius: CGFloat = 8, fill: some ShapeStyle = .backgroundColor) -> some View{
        background(RoundedRectangle(cornerRadius: radius).fill(fill))
    }
    
}

extension Animation{
    static let FPSpring = Animation.spring(dampingFraction: 0.5)
    static let FPEase = Animation.spring(dampingFraction: 0.5)
}

extension ShapeStyle where Self == Color{
    static var backgroundColor: Color {Color(.systemBackground)}
    static var backgroundColor2: Color {Color(.secondarySystemBackground)}
    static var groupBackroundColor: Color {Color(.systemGroupedBackground)}
    static var groupBackroundColor2: Color {Color(.secondarySystemGroupedBackground)}
}

extension AnyTransition{
    static let delayInsertionOpacity = AnyTransition.asymmetric(
        insertion: .opacity
            .animation(.easeInOut(duration: 0.5).delay(0.2)),
        removal: .opacity
            .animation(.easeInOut(duration: 0.4)))
    
    static let moveUpWithOpacity = AnyTransition.move(edge: .top).combined(with: .opacity)
}

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

extension View{
    func push(to alignment: TextAlignment) -> some View {
        switch alignment {
        case .leading:
            return frame(maxWidth: .infinity, alignment: .leading)
        case .center:
            return frame(maxWidth: .infinity, alignment: .center)
        case .trailing:
            return frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    
    func maxWidth() -> some View {
        push(to: .center)
    }
}

extension AppStorage{
    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
}

extension UserDefaults{
    enum Key: String{
        case shouldUseDarkMode
        case unit
        case startTab
        case foodList
    }
}

//
//  File.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/17.
//
import Foundation

@propertyWrapper struct Suffix: Equatable{
    var wrappedValue: Double
    private let suffix: String
    
    init(wrappedValue: Double, _ suffix: String) {
        self.wrappedValue = wrappedValue
        self.suffix = suffix
    }
    
    var projectedValue: String{
            wrappedValue.formatted() + "\(suffix)"
        }
}

struct Food: Equatable, Identifiable {
    
    let id = UUID()
    
    var name : String
    var image : String
    @Suffix("大卡") var calorie : Double = .zero
    @Suffix("g") var carb: Double = .zero
    @Suffix("g") var fat: Double = .zero
    @Suffix("g") var protein: Double = .zero
    
    static let examples = [
        Food(name: "漢堡",image: "🍔",calorie: 294,carb: 14,fat: 24,protein: 17),
        Food(name: "沙拉",image: "🥗",calorie: 29,carb: 20,fat: 0,protein: 1.8),
        Food(name: "比薩",image: "🍕",calorie: 266,carb: 33,fat: 10,protein: 11),
        Food(name: "義大利麵",image: "🍝",calorie: 339,carb: 74,fat: 1.1,protein: 12),
        Food(name: "雞腿便當",image: "🍗🍱",calorie: 191,carb: 19,fat: 8.1,protein: 11.7),
        Food(name: "刀削麵",image: "🍜",calorie: 256,carb: 56,fat: 1,protein: 8),
        Food(name: "火鍋",image: "🍲",calorie: 233,carb: 26.5,fat: 17,protein: 22),
        Food(name: "牛肉麵",image: "🥩🍜",calorie: 219,carb: 33,fat: 5,protein: 9),
        Food(name: "關東煮",image: "🍢",calorie: 80,carb: 4,fat: 4,protein: 6),
    ]
    
    static var new: Food { Food(name: "", image: "")}
}

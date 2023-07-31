//
//  FoodForm.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/29.
//

import SwiftUI

private enum MyField: Int {
    case title, image, calories, protein, fat, carb
}

extension FoodListView{
    struct FoodForm: View {
        @Environment(\.dismiss) var dismiss
        @FocusState private var field: MyField?
        @State var food: Food
        
        var onSubmit: (Food) -> Void
        
        private var isNotValid: Bool{
            food.name.isEmpty || food.image.count > 2
        }
        
        private var invalidMessage: String? {
            if food.name.isEmpty {return "請輸入名稱"}
            if food.image.count > 2 {return "圖示數量過多"}
            return .none
        }
        
        var body: some View {
            NavigationStack {
                VStack {
                    HStack{
                        Label("編輯食物資訊", systemImage: "pencil")
                            .font(.title.bold())
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle.bold())
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                dismiss()
                            }
                    }.padding([.horizontal, .top])
                    
                    Form {
                        LabeledContent("名稱"){
                            TextField("必填", text: $food.name)
                                .submitLabel(.next)
                                .focused($field, equals: .title)
                                .onSubmit {
                                    field = .image
                                }
                        }
                        LabeledContent("圖示"){
                            TextField("只能放置2個圖片", text: $food.image)
                                .submitLabel(.next)
                                .focused($field, equals: .image)
                                .onSubmit {
                                    field = .calories
                                }
                        }
                        builNumberFiled(title: "熱量", value: $food.calorie, suffix: "大卡")
                            .submitLabel(.next)
                            .focused($field, equals: .calories)
                            .onSubmit {
                                field = .protein
                            }
                        builNumberFiled(title: "蛋白質", value: $food.protein)
                            .submitLabel(.next)
                            .focused($field, equals: .protein)
                            .onSubmit {
                                field = .fat
                            }
                        builNumberFiled(title: "脂肪", value: $food.fat)
                            .submitLabel(.next)
                            .focused($field, equals: .fat)
                            .onSubmit {
                                field = .carb
                            }
                        builNumberFiled(title: "碳水", value: $food.carb)
                            .submitLabel(.next)
                            .focused($field, equals: .carb)
                            .onSubmit {
                                field = .carb
                            }
                    }.padding(.top, -16)
                    
                    Button{
                        dismiss()
                        onSubmit(food)
                    }label: {
                        Text(invalidMessage ?? "儲存")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .mainButtonStyle()
                    .padding()
                    .disabled(isNotValid)
                }
                .background(.groupBackroundColor)
                .multilineTextAlignment(.trailing)
                .font(.title3)
                .scrollDismissesKeyboard(.interactively)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button(action: goPreviousField){
                            Image(systemName: "chevron.up")
                        }
                        Button(action: goNextField){
                            Image(systemName: "chevron.down")
                        }
                    }
            }
            }
        }
        
        func goPreviousField() {
            guard let rawValue = field?.rawValue else {return}
            field = .init(rawValue: rawValue - 1)
        }
        
        func goNextField() {
            guard let rawValue = field?.rawValue else {return}
            field = .init(rawValue: rawValue + 1)
        }
        
        private func builNumberFiled(title: String, value: Binding<Double>, suffix: String = "g") -> some View{
            LabeledContent(title){
                HStack {
                    TextField("", value: value, format: .number.precision(.fractionLength(1)))
                        .keyboardType(.decimalPad)
                    Text("大卡")
                }
            }
        }
    }
}

struct FoodForm_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView.FoodForm(food: Food.examples.first!) {_ in }
    }
}

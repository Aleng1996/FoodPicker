//
//  FoodListView.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/21.
//

import SwiftUI

private enum Sheet: View, Identifiable{
    case newFood((Food) -> Void)
    case editFood(Binding<Food>)
    case foodDetail(Food)
    
    var body: some View{
        switch self{
        case .newFood(let onSubmit):
            FoodListView.FoodForm(food: .new, onSubmit: onSubmit)
        case .editFood(let binding):
            FoodListView.FoodForm(food: binding.wrappedValue) { binding.wrappedValue = $0 }
        case .foodDetail(let food):
            FoodListView.FoodDetailSheet(food: food)
        }
    }
    
    var id: UUID{
        switch self{
        case .newFood:
            return UUID()
        case.editFood(let binding):
            return binding.wrappedValue.id
        case .foodDetail(let food):
            return food.id
        }
    }
    
}

struct FoodListView: View {
    
    @Environment(\.editMode) var editMode
    @State private var food = Food.examples
    @State private var selectedFoodID = Set<Food.ID>()
    
    
    @State private var sheet: Sheet?
    
    var isEditing : Bool { editMode?.wrappedValue == .active }
    
    var body: some View {
        VStack(alignment: .leading){
            
            titleBar
            
            List($food, editActions: .all, selection: $selectedFoodID){ $food in
                HStack{
                    Text(food.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isEditing {
                                selectedFoodID.insert(food.id)
                                return
                            }
                            sheet = .foodDetail(food)
                        }
                    if isEditing{
                        Image(systemName: "pencil")
                            .font(.title2.bold())
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                sheet = .editFood($food)
                            }
                    }
                }
            }
            .listStyle(.plain)
            .padding(.horizontal)
        }
        .background(.groupBackroundColor)
        .safeAreaInset(edge: .bottom, alignment: isEditing ? .center : .trailing){
            if isEditing{
                removeButton
            } else {
                addButton
            }
        }
        .sheet(item: $sheet){ $0 }
    }
}

private extension FoodListView{
    struct FoodDetailSheetHeightKey: PreferenceKey {
        static var defaultValue: CGFloat = 300
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct FoodDetailSheet: View{
        
        @State private var foodDetailHight: CGFloat = FoodDetailSheetHeightKey.defaultValue
        
        let food: Food
        
        var body: some View{
            
            HStack(spacing: 30){
                Text(food.image)
                    .font(.system(size: 100))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5
                    )
                
                Grid(horizontalSpacing: 12, verticalSpacing: 12){
                    buildNutritionView(title: "熱量", value: food.$calorie)
                    buildNutritionView(title: "蛋白質", value: food.$protein)
                    buildNutritionView(title: "脂肪", value: food.$fat)
                    buildNutritionView(title: "碳水", value: food.$carb)
                }
                .font(.title3)
                .padding()
            }
            .overlay{
                GeometryReader { proxy in
                    Color.clear.preference(key: FoodDetailSheetHeightKey.self, value: proxy.size.height)
                    
                }
            }
            .onPreferenceChange(FoodDetailSheetHeightKey.self){
                foodDetailHight = $0
            }
            .presentationDetents([.height(foodDetailHight)])
            
        }
        
        func buildNutritionView(title: String, value: String) -> some View{
            GridRow{
                Text(title).gridCellAnchor(.leading)
                Text(value).gridCellAnchor(.trailing)
            }
        }
    }
}

private extension FoodListView{
    var titleBar: some View{
        HStack{
            Label("食物清單", systemImage: "fork.knife")
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            EditButton()
                .buttonStyle(.bordered)
        }.padding()
    }
    var addButton: some View{
        Button {
            sheet = .newFood {food.append($0)}
        }label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .padding()
                .symbolRenderingMode(.palette) //symbol風格調整，.palette色盤風格
                .foregroundStyle(.white, Color.accentColor.gradient) //前為底色，後為主要顏色
        }
    }
    var removeButton: some View{
        Button {
            withAnimation {
                food = food.filter{ !selectedFoodID.contains($0.id) }
            }
        }label: {
            Image(systemName: "trash.fill")
                .font(.system(size: 50))
                .padding()
                .foregroundStyle(Color.red)
        }
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
    }
}

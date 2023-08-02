//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/31.
//

import SwiftUI

extension HomeScreen{
    enum Tab: View, CaseIterable{
        case picker, list
        
        var body: some View{
            content.tabItem{ tabLable.labelStyle(.iconOnly) }
        }
        
        @ViewBuilder
        private var content:some View{
            switch self{
            case .picker: ContentView()
            case .list: FoodListView()
            }
        }
        
        private var tabLable:some View{
            switch self{
            case .picker:
                return Label("Home", systemImage: "house")
            case .list:
                return Label("List", systemImage: "list.bullet")
            }
        }
        
    }
}


struct HomeScreen: View {
    
    @State var tab: Tab = .list
    
    var body: some View {
        TabView(selection: $tab) {
            ForEach(Tab.allCases,  id: \.self){$0}
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

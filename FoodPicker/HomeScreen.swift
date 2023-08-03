//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by A Leng on 2023/7/31.
//

import SwiftUI

extension HomeScreen{
    enum Tab: String, View, CaseIterable{
        case picker, list, settings
        
        var body: some View{
            content.tabItem{ tabLable.labelStyle(.iconOnly) }
        }
        
        @ViewBuilder
        private var content:some View{
            switch self{
            case .picker: ContentView()
            case .list: FoodListView()
            case .settings: SettingsScreen()
            }
        }
        
        private var tabLable:some View{
            switch self{
            case .picker:
                return Label("Home", systemImage: "house")
            case .list:
                return Label("List", systemImage: "list.bullet")
            case .settings:
                return Label("Setting", systemImage: "gear")
            }
        }
        
    }
}


struct HomeScreen: View {
    @AppStorage(.shouldUseDarkMode) var shouldUseDarkMode = false
    @State var tab: Tab = {
        let rawValue = UserDefaults.standard.string(forKey: UserDefaults.Key.startTab.rawValue) ?? ""
        return Tab(rawValue: rawValue) ?? .picker
    }()
    
    var body: some View {
        NavigationStack{
            TabView(selection: $tab) {
                ForEach(Tab.allCases,  id: \.self){$0}
            }.preferredColorScheme(shouldUseDarkMode ? .dark : .light)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

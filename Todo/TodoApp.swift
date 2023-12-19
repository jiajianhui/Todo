//
//  TodoApp.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ListView()
                    .tabItem {
                        Image(systemName: "bubbles.and.sparkles")
                        Text("灵感")
                    }
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("设置")
                    }
            }
            
        }
    }
}

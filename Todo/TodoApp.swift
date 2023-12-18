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
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                        Text("待办")
                    }
                    
                CollectView()
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("收藏")
                    }
            }
            
        }
    }
}

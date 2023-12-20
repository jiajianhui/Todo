//
//  TodoApp.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI
import LocalAuthentication

@main
struct TodoApp: App {
    
    @AppStorage("isToggle") var isToggle: Bool = false  //将该变量存储起来
    @State var locked: Bool = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if locked && isToggle {
                    LockedView(authorize: authorize)  //将函数名传递出去即可
                } else {
                    TabView {
                        ListView()
                            .tabItem {
                                Image(systemName: "bubbles.and.sparkles")
                                Text("灵感")
                            }
                        
                        SettingView(isToggle: $isToggle)
                            .tabItem {
                                Image(systemName: "gear")
                                Text("设置")
                            }
                    }
                }
            }
            .onAppear {
                if isToggle {
                    authorize()
                }
            }
            .onChange(of: isToggle) { newValue in
                if newValue {
                    authorize()
                }
            }
        }
    }
    
    func authorize() {
        let context = LAContext()  //开发者与框架间的中介
        var error: NSError?  //框架要求的错误类型
        
        //1、判断设备是否支持FaceID或TouchID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //2、识别函数
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "解锁应用") { result, _ in
                if result {
                    locked = false
                }
            }
        }
    }
    
}

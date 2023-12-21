//
//  LockedView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/20.
//

import SwiftUI

struct LockedView: View {
    
    var authorize: () -> ()  //函数类型，无参数、返回值
    
    var body: some View {
        Button {
            authorize()
        } label: {
            VStack {
                Image(systemName: "faceid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 4)
                Text("点击解锁")
            }
            .foregroundColor(.primary.opacity(0.4))
            .offset(y: -30)
        }
    }
}

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView(authorize: test)
    }
    
    static func test() {
        print("hello")
    }
}

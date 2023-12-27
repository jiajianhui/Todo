//
//  PrivacySheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/20.
//

import SwiftUI

struct PrivacySheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🙅")
                        .font(.system(size: 46))
                    Text("隐私大于一切！！！")
                    Text("我们非常在意您的隐私，绝对不会上传您的任何数据，所有数据均在设备端离线运行。")
                }
                .lineSpacing(7)
                .padding(.horizontal, 16)
                .padding(.top, 4)
            }
            .navigationTitle("隐私政策")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XmarkView(dismiss: _dismiss)
                }
            }
        }
        
    }
}

struct PrivacySheetView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacySheetView()
    }
}

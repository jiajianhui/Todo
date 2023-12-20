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
                Text("我们非常在意悠的隐私，绝对不会上传您的任何图片以及任何数据，所有智能检测均在设备端离线运行。")
                    .padding(.horizontal, 12)
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

//
//  AboutMeSheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/19.
//

import SwiftUI

struct AboutMeSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    private let me: String = "创造深植于内心，一直以来，开发一款APP"
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("👋")
                        .font(.system(size: 46))
                    Text("创造深植于内心，上架一款APP是我一直以来的心愿")
                    Text("进入新的领域，学习新的知识，从来都是让我无比兴奋的事情；这一次我使用 SwiftUI 来完成这一款APP，过程充满乐趣与挑战，在经历过无数次 Build Succeeded 后，终于完成了这款APP")
                }
                .lineSpacing(7)
                .padding(.horizontal, 16)
                .padding(.top, 4)
                    
            }
            .navigationTitle("关于开发者")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XmarkView(dismiss: _dismiss)
                }
            }
        }
    }
}

struct AboutMeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeSheetView()
    }
}

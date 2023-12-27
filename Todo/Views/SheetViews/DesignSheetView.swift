//
//  DesignSheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/19.
//

import SwiftUI

struct DesignSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("🫧")
                        .font(.system(size: 46))
                    Text("头脑中的灵感转瞬即逝，就像泡泡；快速捕捉这些灵感是这款APP的核心功能")
                    Text("大多数类似的产品都能满足上述需求，但是又不够专一和纯粹，夹杂着太多功能，让人望而却步")
                }
                .lineSpacing(7)
                .padding(.horizontal, 16)
                .padding(.top, 4)
            }
            .navigationTitle("设计初衷")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    XmarkView(dismiss: _dismiss)
                }
            }
        }
    }
}

struct DesignSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DesignSheetView()
    }
}

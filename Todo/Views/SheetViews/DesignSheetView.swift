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
                    Text("头脑中的灵感转瞬即逝，就像泡泡。")
                    Text("我想做一款简单的App，记录这些灵感，让灵感持续发生。")
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

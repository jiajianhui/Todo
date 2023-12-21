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
                Text("design")
                    .padding(.horizontal, 12)
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
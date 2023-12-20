//
//  AboutMeSheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/19.
//

import SwiftUI

struct AboutMeSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text("develeper")
                    .padding(.horizontal, 12)
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

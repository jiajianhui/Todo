//
//  NoListView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/18.
//

import SwiftUI

struct NoListView: View {
    
    @State var title: String
    @State var image: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 80)
            Text(title)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(uiColor: .systemGray4))
        .offset(y: 200)
    }
}

struct NoListView_Previews: PreviewProvider {
    static var previews: some View {
        NoListView(title: "赶快添加你的第一个想法", image: "bubbles.and.sparkles")
    }
}

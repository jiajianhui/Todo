//
//  ListRowView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct ListRowView: View {
    
    var listItem: ListItem
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(listItem.title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(listItem.content)
                .foregroundColor(.secondary)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(listItem: ListItem(id: UUID(), title: "title", content: "content"))
    }
}

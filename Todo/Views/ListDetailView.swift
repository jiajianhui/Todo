//
//  ListDetailView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/18.
//

import SwiftUI

struct ListDetailView: View {
    
    @Binding var listItem: ListItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                Text(listItem.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(listItem.content)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                listItem.collected.toggle()
            } label: {
                Image(systemName: listItem.collected ? "star.fill" : "star")
                    .foregroundColor(.orange)
                    .opacity(0)
            }
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListDetailView(listItem: .constant(ListItem(id: UUID(), title: "hello", content: "world", collected: true)))
        }
        
    }
}

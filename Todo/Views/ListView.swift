//
//  ListView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct ListView: View {
    
    //初始化数据源
    @StateObject var listData = ListData()
    
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listData.lists) { item in
                    ListRowView(listItem: item)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("TodoList")
            .toolbar {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
            .sheet(isPresented: $showSheet) {
                AddTodoSheetView(listData: listData)
            }
        }
    }
    
    //删除函数
    private func delete(atOffsets: IndexSet) {
        listData.lists.remove(atOffsets: atOffsets)
        listData.saveList()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

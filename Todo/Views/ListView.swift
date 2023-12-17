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
                ForEach(listData.lists.indices, id: \.self) { index in  //获取集合索引的方式，它返回一个范围
                    ListRowView(listItem: listData.lists[index])
                        .swipeActions(allowsFullSwipe: true) {
                            Button("删除", role: .destructive) {  //使用role，删除时会有过渡效果
                                delete(at: index)
                            }
                            
                            Button("收藏") {
                                
                            }
                            .tint(.orange)
                        }
                }
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
    private func delete(at index: Int) {
        listData.lists.remove(at: index)
        listData.saveList()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

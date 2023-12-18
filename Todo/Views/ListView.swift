//
//  ListView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct ListView: View {
    
    //接受数据源
    @EnvironmentObject var listData: ListData
    
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !listData.lists.isEmpty {
                    List {
                        ForEach(listData.lists.indices, id: \.self) { index in  //获取集合索引的方式，它返回一个范围
                            
                            NavigationLink {
                                ListDetailView(listItem: $listData.lists[index])
                            } label: {
                                ListRowView(listItem: listData.lists[index])
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button("删除", role: .destructive) {  //使用role，删除时会有过渡效果
                                            delete(at: index)
                                        }
                                        
                                        Button(listData.lists[index].collected ? "取消收藏" : "收藏") {
                                            collect(at: index)
                                        }
                                        .tint(.orange)
                                    }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    NoListView(title: "赶快添加你的第一个想法", image: "wand.and.stars")
                }
            }
            .navigationTitle("待办列表")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UIImpactFeedbackGenerator.impact(style: .light)
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .fontWeight(.medium)
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddTodoSheetView(listData: listData)
            }
        }
    }
    
    //删除函数
    func delete(at index: Int) {
        listData.lists.remove(at: index)
        listData.saveList()
    }
    
    //收藏函数
    func collect(at index: Int) {
        listData.lists[index].collected.toggle()
        listData.saveList()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListData())
    }
}

//
//  ListView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct ListView: View {
    
    //初始化数据源
    @EnvironmentObject var listData: ListData
    
    @State var showSheet = false
    
    //picker
    @State var pickerValue = "全部"
    var pickerTitle = ["全部", "收藏"]
    
    @State var filterLists: [ListItem] = []
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !filterLists.isEmpty {
                    LazyVStack(spacing: 12) {
                        ForEach(filterLists.indices, id: \.self) { index in  //获取集合索引的方式，它返回一个范围
                            
                            NavigationLink {
                                ListDetailView(listItem: $filterLists[index])
                                
                            } label: {
                                ListRowView(listItem: filterLists[index])
                                    .swipeActions(allowsFullSwipe: true) {
                                        Button("删除", role: .destructive) {  //使用role，删除时会有过渡效果
                                            delete(at: index)
                                        }
                                        
                                        Button(filterLists[index].collected ? "取消收藏" : "收藏") {
                                            collect(at: index)
                                        }
                                        .tint(.orange)
                                    }
                                    
                            }
                            
                            .listRowSeparator(.hidden)  //隐藏分割线
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal, 16)
                } else if pickerValue == "收藏" && filterLists.filter{$0.collected}.isEmpty {
                    NoListView(title: "暂无收藏内容", image: "star")
                } else {
                    NoListView(title: "赶快添加你的第一个想法", image: "bubbles.and.sparkles")
                }
            }
            .navigationTitle("灵感列表")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("picker", selection: $pickerValue) {
                        ForEach(pickerTitle, id: \.self) { title in
                            Text(title)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 160)
                    
                    //监测picker选项的变化
                    .onChange(of: pickerValue) { _ in
                        updateLists()
                    }
                }
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
                AddTodoSheetView()
            }
            .background {
                Color(uiColor: .systemGray6).ignoresSafeArea()
            }
            
        }
        
        //初次启动时数据更新
        .onAppear {
            updateLists()
        }
        //及时的数据更新
        .onChange(of: listData.lists) { _ in
            updateLists()
        }
    }
    
    //删除函数
    func delete(at index: Range<Array<ListItem>.Index>.Element) {
        listData.lists.remove(at: index)
        listData.saveList()
    }
    
    //收藏函数
    func collect(at index: Range<Array<ListItem>.Index>.Element) {
        listData.lists[index].collected.toggle()
        listData.saveList()
    }
    
    //数据筛选
    func updateLists() {
        if pickerValue == "全部" {
            filterLists = listData.lists
        } else {
            filterLists = listData.lists.filter{$0.collected}
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListData())
    }
}

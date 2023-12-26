//
//  ListView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI
import SwipeActions

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
                    SwipeViewGroup {
                        LazyVStack(spacing: 12) {
                            ForEach(filterLists.indices, id: \.self) { index in  //获取集合索引的方式，它返回一个范围
                                
                                NavigationLink {
                                    ListDetailView(listItem: $filterLists[index])
                                    
                                } label: {
                                    SwipeView {
                                        ListRowView(listItem: filterLists[index])
                                    } trailingActions: { context in

                                        SwipeAction(
                                            filterLists[index].collected ? "取消收藏" : "收藏",
                                            backgroundColor: .orange.opacity(0.05)
                                        ) {
                                            context.state.wrappedValue = .closed
                                            collect(at: index)
                                        }
                                        .font(.title3.weight(.bold))
                                        .foregroundColor(.orange)

                                        SwipeAction(
                                            "删除",
                                            backgroundColor: .red.opacity(0.05)
                                        ) {
                                            context.state.wrappedValue = .closed
                                            delete(at: index)
                                        }
                                        .font(.title3.weight(.bold))
                                        .foregroundColor(.red)
                                    }
                                    .swipeActionsMaskCornerRadius(12) //控制整个滑动按钮区域的圆角
                                    .swipeActionCornerRadius(12)  //控制内部单个按钮的圆角
                
                                    
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
                            }
                        }
                        .foregroundColor(.primary)
                    .padding(.horizontal, 16)
                    }
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

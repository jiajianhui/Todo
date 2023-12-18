//
//  CollectView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/17.
//

import SwiftUI

struct CollectedView: View {
    
    //接受数据源
    @EnvironmentObject var listData: ListData
    
    private var collectedLists: [ListItem] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if !listData.lists.filter{$0.collected}.isEmpty {
                    List {
                        ForEach(listData.lists.filter{$0.collected}) { item in
                            ListRowView(listItem: item)
                        }
                    }
                } else {
                    NoListView(title: "暂无收藏的内容", image: "star.fill")
                }
            }
            .navigationTitle("收藏列表")
        }
    }
}

struct CollectView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedView()
            .environmentObject(ListData())
    }
}

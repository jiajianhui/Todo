//
//  ListData.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import Foundation



//模型
struct ListItem: Identifiable, Codable {
    var id: UUID
    var title: String
    var content: String
}


//数据源
class ListData: ObservableObject {
    @Published var lists: [ListItem] = []
    
    //1、 获取沙盒地址
    static let sandBoxURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    //2、 创建数据的沙盒地址
    var listsURL = sandBoxURL.appendingPathComponent("lists.json")
    
    
    
    init() {
        lists = getList()
        print("11")
    }
    
    //获取数据
    func getList() -> [ListItem] {
        var result: [ListItem] = []
        
        if FileManager.default.fileExists(atPath: listsURL.path) {
            if let data = try? Data(contentsOf: listsURL) {
                result = try! JSONDecoder().decode([ListItem].self, from: data)
            }
        }
        
        return result
    }
    
    //存储数据
    func saveList() {
        let data = try? JSONEncoder().encode(self.lists)  //将数据编码为json格式
        try? data?.write(to: self.listsURL)  //将数据写入文件
    }
}

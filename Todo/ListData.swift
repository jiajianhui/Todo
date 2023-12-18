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
    var collected = false
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
    }
    
    //获取数据
    func getList() -> [ListItem] {
        var result: [ListItem] = []
        
        if FileManager.default.fileExists(atPath: listsURL.path) {  //判断沙盒中是否存在listsURL
            if let data = try? Data(contentsOf: listsURL) {  //提取listsURL中的数据
                result = try! JSONDecoder().decode([ListItem].self, from: data)  //将数据解码为[ListItem]类型
            }
        }
        
        return result
    }
    
    //存储数据
    func saveList() {
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? JSONEncoder().encode(self.lists)  //将数据编码为json格式
            try? data?.write(to: self.listsURL)  //将数据写入文件
        }
    }
}

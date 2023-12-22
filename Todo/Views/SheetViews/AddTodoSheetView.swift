//
//  AddTodoSheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct AddTodoSheetView: View {
    
    @State var textFieldValue = ""
    @State var textEditorValue = ""
    
    var listData: ListData
    
    //关闭弹窗
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("主题名称")
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextField("请输入标题...", text: $textFieldValue)
                            .padding()
                            .background(Color.white.cornerRadius(16))
                    }
                    VStack(alignment: .leading) {
                        Text("主题描述")
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextEditor(text: $textEditorValue)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .frame(minHeight: 500)
                            .background(Color.white.cornerRadius(16))
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("添加灵感")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addTodo()
                    } label: {
                        Text("添加")
                            .fontWeight(.medium)
                    }
                }
            }
            .padding(.horizontal)
            .background {
                Color(uiColor: .systemGray6).ignoresSafeArea()
            }
            
        }
    }
    
    //添加todo函数
    func addTodo() {
        UIImpactFeedbackGenerator.impact(style: .light)
        let id = UUID()
        let newTodo = ListItem(
            id: id,
            title: textFieldValue,
            content: textEditorValue
        )
        listData.lists.append(newTodo)
        listData.saveList()
        dismiss()
    }
}

struct AddTodoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheetView(listData: ListData())
    }
}

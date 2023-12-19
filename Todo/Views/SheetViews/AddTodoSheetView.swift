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
                VStack(spacing: 14) {
                    TextField("请输入标题...", text: $textFieldValue)
                        .padding()
                        .background(Color(uiColor: .systemGray6).cornerRadius(12))
                    TextEditor(text: $textEditorValue)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .frame(minHeight: 500)
                        .background(Color(uiColor: .systemGray6).cornerRadius(12))
                }
            }
            .navigationTitle("添加待办事项")
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

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
    
    //键盘
    enum Field {
        case textField1
        case textField2
    }
    @FocusState private var focused: Field?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("主题名称")
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextField("请输入标题...", text: $textFieldValue)
                            .padding()
                            .background(Color.white.cornerRadius(16))
                            .focused($focused, equals: .textField1)
                            .submitLabel(.done)  //自定义键盘上提交按钮的文案
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
            
            //自动唤起键盘
            .onAppear {
                focused = .textField1
                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
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

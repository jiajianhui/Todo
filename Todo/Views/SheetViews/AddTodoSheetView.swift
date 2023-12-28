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
    
    @EnvironmentObject var listData: ListData
    
    //关闭弹窗
    @Environment(\.dismiss) private var dismiss
    
    //键盘
    enum Field {
        case textField1
        case textField2
    }
    @FocusState private var focused: Field?
    
    //alert
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("主题名称")
                            .font(.system(size: 14))
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextField("请输入标题...", text: $textFieldValue)
                            .padding()
                            .background(Color("white").cornerRadius(16))
                            .focused($focused, equals: .textField1)
                            .submitLabel(.done)  //自定义键盘上提交按钮的文案
                    }
                    VStack(alignment: .leading) {
                        Text("主题描述")
                            .font(.system(size: 14))
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextEditor(text: $textEditorValue)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .frame(minHeight: 500)
                            .background(Color("white").cornerRadius(16))
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
                        //trimmingCharacters方法会删除字符串开头和结尾的空格和换行符，以此来判断输入框是否为空或是空格
                        if textFieldValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            focused = nil  //关闭键盘
                            showAlert.toggle()
                        } else {
                            addTodo()
                        }
                    } label: {
                        Text("添加")
                            .fontWeight(.medium)
                    }
                }
            }
            .padding(.horizontal)
            .background {
                Color("bgColor").ignoresSafeArea()
            }
            
            //自动唤起键盘
            .onAppear {
                focused = .textField1
            }
            //判断主题名称是否为空
            .alert(isPresented: $showAlert) {
                Alert(title: Text("主题名称不能为空"), dismissButton: .default(Text("我知道了")))
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
            content: textEditorValue,
            timeStamp: Date()
        )
        listData.lists.append(newTodo)
        listData.saveList()
        dismiss()
    }
    
}

struct AddTodoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoSheetView()
    }
}

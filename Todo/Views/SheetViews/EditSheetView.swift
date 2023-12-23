//
//  EditSheetView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/21.
//

import SwiftUI


struct EditSheetView: View {
    
    @EnvironmentObject var listData: ListData
    
    @Binding var listItem: ListItem
    
    @Environment(\.dismiss) var dismiss
    
    @State private var index = 0
    
    //alert
    @State private var showAlert = false
    
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
                        TextField("请输入标题...", text: $listItem.title)
                            .padding()
                            .background(Color.white.cornerRadius(16))
                            .focused($focused, equals: .textField1)
                            .submitLabel(.done)  //自定义键盘上提交按钮的文案
                    }
                    VStack(alignment: .leading) {
                        Text("主题描述")
                            .foregroundColor(.primary.opacity(0.4))
                            .padding(.horizontal, 12)
                        TextEditor(text: $listItem.content)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .frame(minHeight: 500)
                            .background(Color.white.cornerRadius(16))
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("编辑")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        listItem = listData.lists[index]  //即使编辑后，取消后，数据仍保持原样
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if listItem.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            focused = nil  //关闭键盘
                            showAlert.toggle()
                        } else {
                            edit()
                            dismiss()
                        }
                    } label: {
                        Text("完成")
                            .fontWeight(.medium)
                    }
                }
            }
            .onChange(of: listData.lists, perform: { _ in
                print("数据已修改")  //debug
            })
            .padding(.horizontal)
            .background {
                Color(uiColor: .systemGray6).ignoresSafeArea()
            }
            //记录原始数据的索引
            .onAppear {
                print(listItem)
                if let index = listData.lists.firstIndex(of: listItem) {
                    self.index = index
                }
            }
            //自动唤起键盘
            .onAppear {
                focused = .textField1
            }
            //alert
            .alert(isPresented: $showAlert) {
                Alert(title: Text("主题名称不能为空"), dismissButton: .default(Text("我知道了")))
            }
        }
    }
    
    private func edit() {
        UIImpactFeedbackGenerator.impact(style: .light)
        print("edit")
        listData.lists[index] = listItem
        print("ok")
        listData.saveList()
    }
    
    //???
    private func edit2() {
        print(listItem)
        if let index = listData.lists.firstIndex(of: self.listItem) {  //找不到的原因可能是，修改完后，无法找到原数据在数组中的索引
            listData.lists[index].title = listItem.title
            print("ok")
            listData.saveList()
        }
    }
    
}

struct EditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        EditSheetView(listItem: .constant(ListItem(id: UUID(), title: "hello", content: "world")))
            .environmentObject(ListData())
    }
}

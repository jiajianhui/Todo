//
//  ListDetailView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/18.
//

import SwiftUI

struct ListDetailView: View {
    
    @EnvironmentObject var listData: ListData
    
    @Binding var listItem: ListItem
    
    @State var showAlert = false
    @State var showEditSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 6) {
                Text(listItem.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(listItem.content)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .sheet(isPresented: $showEditSheet) {
                EditSheetView(listItem: $listItem)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Menu {
                Section {
                    Button("编辑") {
                        showEditSheet.toggle()
                    }
                    Button(listItem.collected ? "取消收藏" : "收藏") {
                        collected()
                    }
                }
                
                Button(role: .destructive) {
                    showAlert.toggle()
                } label: {
                    Text("删除")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("确定要删除吗🤔"),
                    primaryButton: .destructive(Text("确定"), action: {
                        delete()
                    }),
                    secondaryButton: .cancel(Text("取消")))
            }
        }
        
        
        
    }
    
    private func delete() {
        if let index = listData.lists.firstIndex(of: listItem) {
            listData.lists.remove(at: index)
            listData.saveList()
            presentationMode.wrappedValue.dismiss()
        }
    }
    private func collected() {
        if let index = listData.lists.firstIndex(of: listItem) {
            listData.lists[index].collected.toggle()
            listData.saveList()
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListDetailView(listItem: .constant(ListItem(id: UUID(), title: "hello", content: "world", collected: true, timeStamp: Date())))
        }
        
    }
}

//
//  ListRowView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/16.
//

import SwiftUI

struct ListRowView: View {
    
    var listItem: ListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(listItem.title)
                .font(.title2)
                .fontWeight(.semibold)
            Text(listItem.content)
                .foregroundColor(.secondary)
        }
        .lineLimit(1)
        .padding()
        .padding(.vertical, 8)
        .padding(.bottom, 20)
        
        .frame(maxWidth: .infinity, alignment: .leading)
        .background{Color.white}
        .overlay(alignment: .bottom, content: {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text(displayDate(listItem.timeStamp))
                }
                .foregroundColor(.primary.opacity(0.4))
                
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .opacity(listItem.collected ? 1 : 0)
            }
            .font(.system(size: 14))
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background {
                Color(uiColor: .systemGray).opacity(0.06)
            }
        })
        .cornerRadius(12)
        .shadow(color: Color(uiColor: .systemGray3), radius: 0.6, x: 0, y: 0)
    }
    
    //时间格式化；dateFormatter是DateFormatter的实例对象
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "zh_Hans")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm MM-dd") //自定义时间模版

        return formatter
    }()
    
    //将时间转为字符串
    func displayDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(
            listItem: ListItem(id: UUID(), title: "hello", content: "world", collected: true, timeStamp: Date())
        )
    }
}

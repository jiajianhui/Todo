//
//  SettingRowView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/19.
//

import SwiftUI

struct SettingRowView: View {
    
    
    var imageString: String
    var linkTitle: String
    var color: Color = .primary
    
    
    var body: some View {
        HStack {
            Image(systemName: imageString)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .opacity(0.3)
            Text(linkTitle)
                .fontWeight(.medium)
            Spacer()
            Image(systemName: "chevron.right")
                .opacity(0.3)
        }
        .padding(.vertical, 8)
        .foregroundColor(color)

    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(imageString: "hand.raised.slash.fill", linkTitle: "隐私协议")
    }
}

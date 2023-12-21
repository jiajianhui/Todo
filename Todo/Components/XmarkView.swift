//
//  XmarkView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/20.
//

import SwiftUI

struct XmarkView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .fontWeight(.bold)
                .foregroundColor(.secondary.opacity(0.6))
                .background {
                    Circle()
                        .foregroundColor(Color(uiColor: .systemGray2).opacity(0.2))
                        .frame(width: 28, height: 28)
                }
                .padding(.trailing, 10)
        }
    }
}

struct XmarkView_Previews: PreviewProvider {
    static var previews: some View {
        XmarkView()
    }
}

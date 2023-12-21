//
//  HandleBarView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/20.
//

import SwiftUI

struct HandleBarView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(uiColor: .systemGray5))
            .frame(width: 34, height: 5)
    }
}

struct HandleBarView_Previews: PreviewProvider {
    static var previews: some View {
        HandleBarView()
    }
}

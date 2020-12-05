//
//  CustomTextView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/11/2020.
//

import SwiftUI

struct CustomTextView: View {
    var title: String?
    var value: String?
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if let title = self.title {
                Text(title)
            }
            if let value = self.value {
                Text(value)
            }
        }
        .padding(.vertical, 10)
    }
}

struct CustomTextView_Previews: PreviewProvider {
    static var title = "title"
    static var value = "value"
    static var previews: some View {
        CustomTextView(title: title, value: value)
    }
}

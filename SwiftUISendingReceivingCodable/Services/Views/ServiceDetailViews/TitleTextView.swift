//
//  TitleTextView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/11/2020.
//

import SwiftUI

struct TitleTextView: View {
    var title: String?
    var body: some View {
        if let title = self.title {
            Text(title)
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

struct TitleTextView_Previews: PreviewProvider {
    static var title = "title"
    static var previews: some View {
        TitleTextView()
    }
}

//
//  TitleTextView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/11/2020.
//

import SwiftUI

struct TitleTextView: View {
    var title = "title"
    var body: some View {
        Text(title)
            .padding(10)
            .font(.title)
            .multilineTextAlignment(.center)
    }
}

struct TitleTextView_Previews: PreviewProvider {
    static var title = "title"
    static var previews: some View {
        TitleTextView()
    }
}

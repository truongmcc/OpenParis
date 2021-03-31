//
//  ServiceCellView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/03/2021.
//

import SwiftUI

struct ServiceCellView: View {
    let name: String
    var body: some View {
        Text(name)
    }
}

struct ServiceCellView_Previews: PreviewProvider {
    static let name = "hello"
    static var previews: some View {
        ServiceCellView(name: name)
    }
}

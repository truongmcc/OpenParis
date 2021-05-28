//
//  ServiceCellView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/03/2021.
//

import SwiftUI

struct ServiceCellView: View {
    let keySearch: String
    var body: some View {
        Text(keySearch)
    }
}

struct ServiceCellView_Previews: PreviewProvider {
    static let keySearch = ""
    static var previews: some View {
        ServiceCellView(keySearch: keySearch)
    }
}

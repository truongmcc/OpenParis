//
//  ServiceCellView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/03/2021.
//

import SwiftUI

struct ServiceCellView: View {
    var annotation: ServiceAnnotation?
    var body: some View {
        if let name = annotation?.name {
            Text(name)
        } else if let adresse = annotation?.adresse {
            Text(adresse)
        }
    }
}

struct ServiceCellView_Previews: PreviewProvider {
    static let annotation = ServiceAnnotation?.self
    static var previews: some View {
        ServiceCellView(annotation: nil)
    }
}

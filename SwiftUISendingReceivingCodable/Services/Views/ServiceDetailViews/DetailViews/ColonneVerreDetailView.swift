//
//  ColonneVerreDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 26/05/2021.
//

import SwiftUI

struct ColonneVerreDetailView: View {
    @State var serviceSelected: ColonneVerre?
    var body: some View {
        VStack(alignment: .center) {
            TitleTextView(title: serviceSelected?.fields?.adresse)
        }
    }
}

struct ColonneVerreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ColonneVerreDetailView()
    }
}

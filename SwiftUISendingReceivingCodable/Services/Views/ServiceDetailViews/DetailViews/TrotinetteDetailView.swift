//
//  TrotinetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import SwiftUI

struct TrotinetteDetailView: View {
    @State var serviceSelected: Trotinette?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("\(serviceSelected?.fields?.adresse ?? "") \(serviceSelected?.fields?.codePostal ?? "")")
                .padding(10)
                .multilineTextAlignment(.center)
        }
    }
}

struct TrotinetteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrotinetteDetailView()
    }
}

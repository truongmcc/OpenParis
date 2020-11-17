//
//  TriMobileDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct TriMobileDetailView: View {
    @State var serviceSelected: TriMobile?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text(serviceSelected?.fields.adresse ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text(serviceSelected?.fields.joursDeTenue ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

struct TriMobileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TriMobileDetailView()
    }
}

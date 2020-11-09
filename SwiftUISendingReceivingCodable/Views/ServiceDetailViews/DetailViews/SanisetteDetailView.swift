//
//  SanisetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

import SwiftUI

struct SanisetteDetailView: View {
    @State var serviceSelected: Sanisette?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("Ardt : \(serviceSelected?.fields.arrondissement ?? "")")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text(serviceSelected?.fields.adresse ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text("Horaire : \(serviceSelected?.fields.horaire ?? "")")
                .padding(10)
                .multilineTextAlignment(.center)
            Text("Acces PMR : \(serviceSelected?.fields.accesPmr ?? "")")
                .padding(10)
                .multilineTextAlignment(.center)
        }
    }
}

struct DetailSanisetteView_Previews: PreviewProvider {
    static var previews: some View {
        SanisetteDetailView()
    }
}

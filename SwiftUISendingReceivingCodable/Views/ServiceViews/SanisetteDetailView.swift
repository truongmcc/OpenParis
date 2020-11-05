//
//  SanisetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

import SwiftUI

struct SanisetteDetailView: View {
    @State var serviceSelected: Sanisette?
    @State var opacityChange = false

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
        .font(.system(size: 20))
        .foregroundColor(.white)
        .cornerRadius(10)
        .opacity(opacityChange ? 1 : 0)
        .animation(.default)
        .onAppear() {
            opacityChange.toggle()
        }
        .onDisappear() {
            opacityChange.toggle()
        }
    }
}

struct DetailSanisetteView_Previews: PreviewProvider {
    static var previews: some View {
        SanisetteDetailView()
    }
}

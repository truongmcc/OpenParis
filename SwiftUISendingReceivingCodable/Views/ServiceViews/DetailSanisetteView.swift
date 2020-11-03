//
//  DetailSanisetteView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

import SwiftUI

struct DetailSanisetteView: View {
    @State var sanisetteSelected: Sanisette?
    @State var opacityChange = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("Ardt : \(sanisetteSelected?.fields.arrondissement ?? "")")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text(sanisetteSelected?.fields.adresse ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text("Horaire : \(sanisetteSelected?.fields.horaire ?? "")")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            Text("Acces PMR : \(sanisetteSelected?.fields.accesPmr ?? "")")
                .padding(10)
                .font(.title)
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
        DetailVelibView()
    }
}

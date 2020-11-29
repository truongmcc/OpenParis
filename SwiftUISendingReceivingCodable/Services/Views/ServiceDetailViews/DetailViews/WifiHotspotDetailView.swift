//
//  WifiHotspotDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 29/11/2020.
//

import SwiftUI

struct WifiHotspotDetailView: View {
    @State var serviceSelected: WifiHotspot?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            Text(serviceSelected?.fields?.nomSite ?? "nom non trouvé")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Adresse : ")
                Text(serviceSelected?.fields?.arcAdresse ?? "" + (serviceSelected?.fields?.cp ?? ""))
            }
            Text("Nombre de bornes : \(serviceSelected?.fields?.nbBorneWifi ?? 0)")
            Text("Id/Password : \(serviceSelected?.fields?.idpw ?? "Inconnu")")
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Etat : ")
                Text(serviceSelected?.fields?.etat2 ?? "Inconnu")
            }
        }
    }
}

struct WifiHotspotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WifiHotspotDetailView()
    }
}

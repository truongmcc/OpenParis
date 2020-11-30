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
            CustomTextView(title: "Adresse : ", value: serviceSelected?.fields?.arcAdresse ?? "" + (serviceSelected?.fields?.cp ?? ""))
            CustomTextView(title: "Nombre de bornes  : ", value: "\(serviceSelected?.fields?.nbBorneWifi ?? 0)")
            CustomTextView(title: "Id/Password  : ", value: serviceSelected?.fields?.idpw ?? "Inconnu")
            CustomTextView(title: "Etat  : ", value: serviceSelected?.fields?.etat2 ?? "Inconnu")
        }
    }
}

struct WifiHotspotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WifiHotspotDetailView()
    }
}

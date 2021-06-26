//
//  WifiHotspotDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 29/11/2020.
//

import SwiftUI

struct ConcreteWifiHotspotDetailView: CreatorFactoryMethod {
    func create(service: Service) -> DetailBaseViewProtocol {
        return WifiHotspotDetailView(service: service as! WifiHotspot)
    }
}

struct WifiHotspotDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var hotSpotWifi: WifiHotspot {
        return service as! WifiHotspot
    }
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            TitleTextView(title: hotSpotWifi.fields?.name ?? "nom non trouvé")
            CustomTextView(title: "\(hotSpotWifi.fields?.arcAdresse ?? "") ", value: hotSpotWifi.fields?.cp)
            CustomTextView(title: "Nombre de bornes  : ", value: "\(hotSpotWifi.fields?.nbBorneWifi ?? 0)")
            CustomTextView(title: "Id/Password  : ", value: hotSpotWifi.fields?.idpw ?? "Inconnu")
            CustomTextView(title: "Etat  : ", value: hotSpotWifi.fields?.etat2 ?? "Inconnu")
        }
    }
}

struct WifiHotspotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WifiHotspotDetailView()
    }
}

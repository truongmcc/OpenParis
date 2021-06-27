//
//  FontaineDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct ConcreteFontaineDetailView: CreatorFactoryMethod {
    func create(service: Service) -> DetailBaseViewProtocol {
        return FontaineDetailView(service: service as! Fontaine)
    }
}

struct FontaineDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var hotSpotWifi: Fontaine {
        return service as! Fontaine
    }
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            TitleTextView(title: createAdress(noImpair: hotSpotWifi.fields?.noVoirieImpair,
                                              noPair: hotSpotWifi.fields?.noVoiriePair,
                                              street: hotSpotWifi.fields?.voie))
            let type = hotSpotWifi.fields?.typeObjet?.split(separator: "_").last
            CustomTextView(title: "type : ", value: String(type ?? "Non renseigné"))
            CustomTextView(title: "disponible : ", value: hotSpotWifi.fields?.dispo)
        }
    }
    
    func createAdress(noImpair: String?, noPair: String?, street: String?) -> String {
        let no = (noImpair ?? "") + (noPair ?? "")
        let adress = no + " " + (street ?? "")
        return adress
    }
}

struct FontaineView_Previews: PreviewProvider {
    static var previews: some View {
        FontaineDetailView()
    }
}

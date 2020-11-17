//
//  FontaineDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct FontaineDetailView: View {
    @State var serviceSelected: Fontaine?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text(createAdress(noImpair: serviceSelected?.fields.noVoirieImpair,
                               noPair: serviceSelected?.fields.noVoiriePair,
                               street: serviceSelected?.fields.voie))
                .padding(10)
                .multilineTextAlignment(.center)
            Text("disponible : \(serviceSelected?.fields.dispo ?? "")")
                .padding(10)
                .multilineTextAlignment(.center)
            Text("type : \(serviceSelected?.fields.typeObjet ?? "")")
                .padding(10)
                .multilineTextAlignment(.center)
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

//
//  SanisetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

import SwiftUI

struct ConcreteSanisetteDetailView: CreatorFactoryMethod {
    func create(service: Service?) -> DetailBaseViewProtocol? {
        return SanisetteDetailView(service: service as! Sanisette)
    }
}

struct SanisetteDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var sanisette: Sanisette {
        return service as! Sanisette
    }
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            TitleTextView(title: sanisette.fields?.adresse ?? "")
            CustomTextView(title: "Horaire : ", value: sanisette.fields?.horaire ?? "Non Renseigné")
            CustomTextView(title: "Acces PMR : ", value: sanisette.fields?.accesPmr ?? "Non Renseigné")
        }
    }
}

struct DetailSanisetteView_Previews: PreviewProvider {
    static var previews: some View {
        SanisetteDetailView()
    }
}

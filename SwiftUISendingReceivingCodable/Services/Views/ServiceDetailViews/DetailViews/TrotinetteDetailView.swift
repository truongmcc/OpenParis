//
//  TrotinetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import SwiftUI

struct ConcreteTrotinetteDetailView: CreatorFactoryMethod {
    func create(service: Service?) -> DetailBaseViewProtocol? {
        return TrotinetteDetailView(service: service as! Trotinette)
    }
}

struct TrotinetteDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var trotinette: Trotinette {
        return service as! Trotinette
    }
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            CustomTextView(title: trotinette.fields?.adresse?.lowercased(), value: trotinette.fields?.codePostal)
        }
    }
}

struct TrotinetteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrotinetteDetailView()
    }
}

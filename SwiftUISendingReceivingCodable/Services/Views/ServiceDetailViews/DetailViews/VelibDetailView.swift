//
//  VelibDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 14/08/2020.
//

import SwiftUI

struct ConcreteVelibDetailView: CreatorFactoryMethod {
    func create(service: Service?) -> DetailBaseViewProtocol? {
        return VelibDetailView(service: service as! Velib)
    }
}

struct VelibDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var velib: Velib {
        return service as! Velib
    }

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            TitleTextView(title: velib.fields?.name ?? "nom non trouvé")
            CustomTextView(title: "Bornes disponibles : ", value: "\(velib.fields?.numDockAvailable ?? 0)")
            CustomTextView(title: "Velibs disponibles : ", value: "\(velib.fields?.numBikesAvailable ?? 0)")
            CustomTextView(title: "Ebikes : ", value: "\(velib.fields?.eBike ?? 0)")
        }
    }
}

struct DetailVelibView_Previews: PreviewProvider {
    static var previews: some View {
        VelibDetailView()
    }
}

//
//  VelibDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 14/08/2020.
//

import SwiftUI

struct VelibDetailView: View {
    @State var serviceSelected: Velib?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            TitleTextView(title: serviceSelected?.fields?.name ?? "nom non trouvé")
            CustomTextView(title: "Bornes disponibles : ", value: "\(serviceSelected?.fields?.numDockAvailable ?? 0)")
            CustomTextView(title: "Velibs disponibles : ", value: "\(serviceSelected?.fields?.numBikesAvailable ?? 0)")
            CustomTextView(title: "Ebikes : ", value: "\(serviceSelected?.fields?.eBike ?? 0)")
        }
    }
}

extension VelibDetailView: ServiceDetailViewProtocol {
    typealias T = VelibDetailView
    func createServiceView<T>(serviceSelected: Service?) -> T {
        VelibDetailView(serviceSelected: serviceSelected as? Velib) as! T
    }
}

struct DetailVelibView_Previews: PreviewProvider {
    static var previews: some View {
        VelibDetailView()
    }
}

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
            Text(serviceSelected?.fields.name ?? "nom non trouvé")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Bornes disponibles : ")
                Text("\(serviceSelected?.fields.numDockAvailable ?? 0)")
            }
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Velibs disponibles : ")
                Text("\(serviceSelected?.fields.numBikesAvailable ?? 0)")
            }
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Ebikes : ")
                Text("\(serviceSelected?.fields.eBike ?? 0)")
            }
        }
    }
}

struct DetailVelibView_Previews: PreviewProvider {
    static var previews: some View {
        VelibDetailView()
    }
}

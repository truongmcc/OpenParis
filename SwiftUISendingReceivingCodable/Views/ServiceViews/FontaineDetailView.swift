//
//  FontaineDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct FontaineDetailView: View {
    @State var serviceSelected: Fontaine?
    @State var opacityChange = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("\(serviceSelected?.fields.commune ?? "")")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
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
        .font(.system(size: 20))
        .foregroundColor(.white)
        .cornerRadius(10)
        .opacity(opacityChange ? 1 : 0)
        .animation(.default)
        .onAppear() {
            opacityChange.toggle()
        }
        .onDisappear() {
            opacityChange.toggle()
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
        VelibDetailView()
    }
}

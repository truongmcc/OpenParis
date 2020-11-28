//
//  ArbreRemarquableDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/11/2020.
//

import SwiftUI

import SwiftUI

struct ArbreRemarquableDetailView: View {
    @State var serviceSelected: ArbreRemarquable?

    var body: some View {
        VStack(alignment: .center) {
            Text(serviceSelected?.fields?.libellefrancais ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            createDetailText(title: "Adresse", value: serviceSelected?.fields?.adresse ?? "")
            createDetailText(title: "Pépinière", value: serviceSelected?.fields?.espece ?? "")
            createDetailText(title: "Genre", value: serviceSelected?.fields?.genre ?? "")
            if let circ = serviceSelected?.fields?.circonferenceencm {
                createDetailText(title: "Circ.", value: String(circ))
            }
            if let taille = serviceSelected?.fields?.hauteurenm, taille != 0.0 {
                createDetailText(title: "Taille", value: String(taille))
            }
            if let formattedDate = serviceSelected?.fields?.dateplantation?.formatDateDMY(date: serviceSelected?.fields?.dateplantation ?? "Date Inconnue"), formattedDate != "01-01-1700" {
                createDetailText(title: "Plantation", value: String(formattedDate))
            }
        }
    }
    
    fileprivate func createDetailText(title: String, value: String) -> some View {
            return Text(title + " : \(value)")
                .padding(10)
                .multilineTextAlignment(.leading)
    }
}

struct ArbreRemarquableDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArbreRemarquableDetailView()
    }
}

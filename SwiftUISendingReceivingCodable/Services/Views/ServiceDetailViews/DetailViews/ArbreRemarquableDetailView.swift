//
//  ArbreRemarquableDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/11/2020.
//

import SwiftUI

struct ArbreRemarquableDetailView: View {
    @State var serviceSelected: ArbreRemarquable?

    var body: some View {
        VStack(alignment: .center) {
            TitleTextView(title: serviceSelected?.fields?.libellefrancais ?? "")
            CustomTextView(title: "Adresse : ", value: serviceSelected?.fields?.adresse ?? "")
            CustomTextView(title: "Pépinière : ", value: serviceSelected?.fields?.espece ?? "")
            CustomTextView(title: "Genre : ", value: serviceSelected?.fields?.genre ?? "")

            if let circ = serviceSelected?.fields?.circonferenceencm {
                CustomTextView(title: "Circonf. (cm) : ", value: String(Int(circ)))
            }
            if let taille = serviceSelected?.fields?.hauteurenm, taille != 0 {
                CustomTextView(title: "Taille (mètres) : ", value: String(Int(taille)))
            }
            if let formattedDate = serviceSelected?.fields?.dateplantation?.formatDateDMY(date: serviceSelected?.fields?.dateplantation ?? "Date Inconnue"),formattedDate != "01-01-1700" {
                CustomTextView(title: "Plantation : ", value: String(formattedDate))
            }
        }
    }
}

struct ArbreRemarquableDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArbreRemarquableDetailView()
    }
}

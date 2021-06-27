//
//  ArbreRemarquableDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/11/2020.
//

import SwiftUI

struct ConcreteArbreRemarquableDetailView: CreatorFactoryMethod {
    func create(service: Service) -> DetailBaseViewProtocol {
        return ArbreRemarquableDetailView(service: service as! ArbreRemarquable)
    }
}

struct ArbreRemarquableDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var arbreRemarquable: ArbreRemarquable {
        return service as! ArbreRemarquable
    }
    var body: some View {
        VStack(alignment: .center) {
            TitleTextView(title: arbreRemarquable.fields?.libellefrancais)
            CustomTextView(title: "Adresse : ", value: arbreRemarquable.fields?.adresse)
            CustomTextView(title: "Pépinière : ", value: arbreRemarquable.fields?.espece)
            CustomTextView(title: "Genre : ", value: arbreRemarquable.fields?.genre)

            if let circ = arbreRemarquable.fields?.circonferenceencm {
                CustomTextView(title: "Circonf. (cm) : ", value: String(Int(circ)))
            }
            if let taille = arbreRemarquable.fields?.hauteurenm, taille != 0 {
                CustomTextView(title: "Taille (mètres) : ", value: String(Int(taille)))
            }
            if let formattedDate = arbreRemarquable.fields?.dateplantation?.formatDateDMY(date: arbreRemarquable.fields?.dateplantation ?? "Date Inconnue"),formattedDate != "01-01-1700" {
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

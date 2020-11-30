//
//  SanisetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 03/11/2020.
//

import SwiftUI

struct SanisetteDetailView: View {
    @State var serviceSelected: Sanisette?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text(serviceSelected?.fields?.adresse ?? "")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            CustomTextView(title: "Horaire : ", value: serviceSelected?.fields?.horaire ?? "")
            CustomTextView(title: "Acces PMR : ", value: serviceSelected?.fields?.accesPmr ?? "")
        }
    }
}

struct DetailSanisetteView_Previews: PreviewProvider {
    static var previews: some View {
        SanisetteDetailView()
    }
}

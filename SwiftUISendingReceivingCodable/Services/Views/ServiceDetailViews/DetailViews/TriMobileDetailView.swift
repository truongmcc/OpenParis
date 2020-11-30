//
//  TriMobileDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct TriMobileDetailView: View {
    @State var serviceSelected: TriMobile?
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            CustomTextView(title: "Adresse : ", value: serviceSelected?.fields?.adresse ?? "")
            CustomTextView(title: "Jours de tenue : ", value: serviceSelected?.fields?.joursDeTenue ?? "")
        }
    }
}

struct TriMobileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TriMobileDetailView()
    }
}

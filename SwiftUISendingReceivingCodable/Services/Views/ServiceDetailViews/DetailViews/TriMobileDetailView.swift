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
            TitleTextView(title: serviceSelected?.fields?.adresse)
            if let complementAdresse = serviceSelected?.fields?.complementAdresse {
                CustomTextView(title: complementAdresse, value: nil)
            }
            CustomTextView(title: serviceSelected?.fields?.joursDeTenue, value: nil)
            CustomTextView(title: serviceSelected?.fields?.horaires, value: nil)
        }
    }
}

struct TriMobileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TriMobileDetailView()
    }
}

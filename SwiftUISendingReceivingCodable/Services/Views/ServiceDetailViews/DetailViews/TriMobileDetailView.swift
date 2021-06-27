//
//  TriMobileDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct ConcreteTriMobileDetailView: CreatorFactoryMethod {
    func create(service: Service) -> DetailBaseViewProtocol {
        return TriMobileDetailView(service: service as! TriMobile)
    }
}

struct TriMobileDetailView: View, DetailBaseViewProtocol {
    var service: Service?
    var triMobile: TriMobile {
        return service as! TriMobile
    }
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            TitleTextView(title: triMobile.fields?.adresse)
            if let complementAdresse = triMobile.fields?.complementAdresse {
                CustomTextView(title: complementAdresse, value: nil)
            }
            CustomTextView(title: triMobile.fields?.joursDeTenue, value: nil)
            CustomTextView(title: triMobile.fields?.horaires, value: nil)
        }
    }
}

struct TriMobileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TriMobileDetailView()
    }
}

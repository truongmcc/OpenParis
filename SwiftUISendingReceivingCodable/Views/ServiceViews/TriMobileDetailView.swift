//
//  TriMobileDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 04/11/2020.
//

import SwiftUI

struct TriMobileDetailView: View {
    @State var triMobileSelected: TriMobile?
    @State var opacityChange = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("\(triMobileSelected?.fields.adresse ?? "") \(triMobileSelected?.fields.codePostal ?? 75000)")
                .padding(10)
                .multilineTextAlignment(.center)
            
            Text("Jours de tenus : \(triMobileSelected?.fields.joursDeTenue ?? "")")
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
}

struct TriMobileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TriMobileDetailView()
    }
}

//
//  TrotinetteDetailView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import SwiftUI

struct TrotinetteDetailView: View {
    @State var serviceSelected: Trotinette?
    @State var opacityChange = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("\(serviceSelected?.fields.adresse ?? "") \(serviceSelected?.fields.codePostal ?? "")")
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

struct TrotinetteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrotinetteDetailView()
    }
}

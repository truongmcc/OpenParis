//
//  DetailTrotinetteView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import SwiftUI

struct DetailTrotinetteView: View {
    @State var trotinetteSelected: Trotinette?
    @State var opacityChange = false
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text("\(trotinetteSelected?.fields.adresse ?? "") \(trotinetteSelected?.fields.code_postal ?? "")")
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

struct DetailTrotinetteView_Previews: PreviewProvider {
    static var previews: some View {
        DetailVelibView()
    }
}

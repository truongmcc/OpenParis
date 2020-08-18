//
//  DetailVelibView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 14/08/2020.
//

import SwiftUI

struct DetailVelibView: View {
    @State var selectedAnnotation: VelibAnnotation?
    @State var opacityChange = false


    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            Text(selectedAnnotation?.name ?? "nom non trouvé")
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Bornes disponibles : ")
                Text("\(selectedAnnotation?.numDockAvailable ?? 0)")
            }
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Velib disponibles : ")
                Text("\(selectedAnnotation?.numBikesAvailable ?? 0)")
            }
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Text("Ebikes : ")
                Text("\(selectedAnnotation?.eBike ?? 0)")
            }
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

struct DetailVelibView_Previews: PreviewProvider {
    static var previews: some View {
        DetailVelibView()
    }
}

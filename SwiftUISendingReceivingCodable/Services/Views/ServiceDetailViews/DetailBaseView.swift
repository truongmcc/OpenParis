//
//  DetailBaseView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 09/11/2020.
//

import SwiftUI

struct DetailBaseView: View {
    @State var serviceSelected: Service?
    var body: some View {
        BaseView() {
            switch serviceSelected?.typeService {
            case .velib:
                VelibDetailView(serviceSelected: serviceSelected as? Velib)
            case .trotinette:
                TrotinetteDetailView(serviceSelected: serviceSelected as? Trotinette)
            case .sanisette:
                SanisetteDetailView(serviceSelected: serviceSelected as? Sanisette)
            case .fontaine:
                FontaineDetailView(serviceSelected: serviceSelected as? Fontaine)
            case .triMobile:
                TriMobileDetailView(serviceSelected: serviceSelected as? TriMobile)
            case .arbreRemarquable:
                ArbreRemarquableDetailView(serviceSelected: serviceSelected as? ArbreRemarquable)
            case .wifiHotspot:
                WifiHotspotDetailView(serviceSelected: serviceSelected as? WifiHotspot)
            case .colonneVerre:
                ColonneVerreDetailView(serviceSelected: serviceSelected as? ColonneVerre)
            case .none:
                Text("")
            }
        }
    }
}

struct BaseView<Content: View>: View {
    @State var opacityChange = false
    @Environment(\.presentationMode) var presentationMode
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        content
            .font(.system(size: 20))
            .padding()
            .foregroundColor(.white)
            .cornerRadius(10)
            .animation(.default)
            .border(Color.primary)
            .background(Color.black.opacity(0.5))
            .opacity(opacityChange ? 1 : 0)
            .onAppear() {
                opacityChange.toggle()
            }
            .onDisappear() {
                opacityChange.toggle()
            }
    }
}

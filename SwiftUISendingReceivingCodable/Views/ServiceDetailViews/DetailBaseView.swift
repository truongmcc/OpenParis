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
            case (.fontaine):
                FontaineDetailView(serviceSelected: serviceSelected as? Fontaine)
            case (.triMobile):
                TriMobileDetailView(serviceSelected: serviceSelected as? TriMobile)
            case .none:
                Text("")
            }
        }
    }
}

struct BaseView<Content: View>: View {
    @State var opacityChange = false
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack() {
            content
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
        .border(Color.primary)
    }
}

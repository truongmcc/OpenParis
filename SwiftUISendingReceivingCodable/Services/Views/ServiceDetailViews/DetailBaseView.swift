//
//  DetailBaseView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 09/11/2020.
//

import SwiftUI

struct DetailBaseView: View {
    var serviceSelected: Service?
    var detailView: some View {
        return serviceSelected?.typeService.createDetailView(serviceSelected: serviceSelected!)
    }

    var body: some View {
        BaseView() {
            detailView
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

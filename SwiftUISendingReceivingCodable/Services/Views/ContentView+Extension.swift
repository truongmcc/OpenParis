//
//  ContentView+Extension.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 28/06/2021.
//

import Foundation
import SwiftUI

extension ContentView {
    
    func showServiceDetail() -> AnyView? {
        guard let service = serviceViewModel.service, service.id != nil else { return nil }
        return AnyView(DetailBaseView(serviceSelected: service))
    }
    
    func showProgressionView() -> some View {
        VStack {
            if showLoadingView {
                ProgressView()
                    .foregroundColor(Color.primary)
            }
        }
    }
    
    func addTitleBar() -> some View {
        return HStack(alignment: .firstTextBaseline) {
            addTitle()
            Spacer()
            Button("Options", action: {
                showPreferencesView.toggle()
            })
            .padding(20)
        }
        .foregroundColor(Color.primary)
    }
    
    func addPositionButton() -> some View {
        return
            GeometryReader { geometryReader in
                VStack {
                    Button("Ma position", action: {
                        mapViewModel.centerUserLocation.toggle()
                    })
                    .padding(20)
                    .multilineTextAlignment(.trailing)
                }
                .foregroundColor(Color.primary)
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .bottomTrailing)
            }
    }
    
    func addTitle() -> some View {
        Text(userSettings.typeService.title())
            .foregroundColor(.primary)
            .font(.title)
            .padding(20)
    }
}

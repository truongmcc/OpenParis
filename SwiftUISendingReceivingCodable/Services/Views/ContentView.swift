//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var serviceViewModel = ServiceViewModel()
    
    @State private var showPreferencesView = false
    @State private var showLoadingView = false
    @State private var showErrorAlert = false
    
    @State private var bottomSheetShown = false
    
    var mapView: MapView {
        serviceViewModel.userSettings = userSettings
        return MapView(mapViewModel: mapViewModel,
                       serviceViewModel: serviceViewModel,
                       userSettings: userSettings,
                       showLoadingView: $showLoadingView,
                       showErrorAlert: $showErrorAlert)
    }
    
    var body: some View {
        ZStack() {
            mapView
                .onTapGesture { serviceViewModel.service = nil }
            VStack {
                addTitleBar()
                addPositionButton()
            }
            showProgressionView()
            showServiceDetail()
            GeometryReader { geometry in
                FilteredServicesView(isOpen: self.$bottomSheetShown, mapView: mapView,
                                 maxHeight: geometry.size.height * 0.7) {
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .alert(isPresented: $showErrorAlert) {
            return AlertManager.shared.createNetworkAlert(completionHandler: { shouldReloadMap in
                if shouldReloadMap {
                    mapView.loadMap()
                }
            })
        }
        .sheet(isPresented: $showPreferencesView) {
            PreferencesView(mapViewModel: mapViewModel, onDismiss: {
                serviceViewModel.service = nil
                mapView.loadMap()
            }).environmentObject(userSettings)
        }
        .onAppear() {
            mapView.loadMap()
        }
    }
}

extension ContentView {
    
    fileprivate func showServiceDetail() -> AnyView? {
        guard let service = serviceViewModel.service, service.id != nil else { return nil }
        return AnyView(DetailBaseView(serviceSelected: service))
    }
    
    fileprivate func showProgressionView() -> some View {
        VStack {
            if showLoadingView {
                ProgressView()
                    .foregroundColor(Color.primary)
            }
        }
    }
    
    fileprivate func addTitleBar() -> some View {
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
    
    fileprivate func addPositionButton() -> some View {
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
    
    fileprivate func addTitle() -> some View {
        Text(userSettings.typeService.title())
            .foregroundColor(.primary)
            .font(.title)
            .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

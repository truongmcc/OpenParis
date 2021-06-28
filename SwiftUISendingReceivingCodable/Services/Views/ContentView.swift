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
    
    @State var showPreferencesView = false
    @State var showLoadingView = false
    @State var showErrorAlert = false
    
    @State private var isFilteringViewShowned = false
    
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
                FilteredServicesView(isOpen: self.$isFilteringViewShowned, mapView: mapView,
                                 maxHeight: geometry.size.height * 0.7) {
                }
            }.edgesIgnoringSafeArea(.all)
        }
        .alert(isPresented: $showErrorAlert) {
            return AlertManager.shared.createNetworkAlert(completionHandler: { shouldReloadMap in
                if shouldReloadMap {
                    mapView.showAllAnnotations()
                }
            })
        }
        .sheet(isPresented: $showPreferencesView) {
            PreferencesView(mapViewModel: mapViewModel, onDismiss: {
                serviceViewModel.service = nil
                mapView.showAllAnnotations()
            }).environmentObject(userSettings)
        }
        .onAppear() {
            mapView.showAllAnnotations()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var serviceViewModel = ServiceViewModel()
    
    @State var showParametersView = false
    @State var showLoadingView = false
    @State var showErrorAlert = false
    
    @State private var isFilteringViewShowned = false

    @StateObject var manager = LocationManager()
    
    let annotations = [
            City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
            City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
            City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
            City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
        ]

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
            mapView // -> TROUVER UN MOYEN DE REMPLACER mapView !!!! par le mode SWIFTUI
            Map(coordinateRegion: $manager.region,
                annotationItems: mapView.mapViewModel.annotations,
                annotationContent: { annotation in
                MapAnnotation(coordinate: annotation.coordinate, content: {
                    Text("hey")
                })
            })
            .edgesIgnoringSafeArea(.all)
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
        .sheet(isPresented: $showParametersView) {
            ParametersView(onDismiss: {
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

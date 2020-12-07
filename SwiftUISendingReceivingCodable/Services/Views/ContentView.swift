//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var mapViewModel = MapViewModel()
    @ObservedObject var serviceViewModel = ServiceViewModel()
    @State private var mapType = MKMapType.standard
    @State private var showOptionsView = false
    @State private var showLoadingView = false
    @State private var showErrorAlert = false
    var mapView: MapView {
        return MapView(mapViewModel: mapViewModel,
                       serviceViewModel: serviceViewModel,
                       showLoadingView: $showLoadingView,
                       showErrorAlert: $showErrorAlert)
    }
    
    var body: some View {
        ZStack() {
            mapView
            VStack {
                addTitleBar()
                addPositionButton()
            }
            showProgressionView()
            showServiceDetail()
        }
        .onTapGesture {
            serviceViewModel.service = nil
        }
        .alert(isPresented: $showErrorAlert) {
            return AlertManager.shared.createNetworkAlert(completionHandler: { shouldReloadMap in
                if shouldReloadMap {
                    mapView.loadMap()
                }
            })
        }
        .sheet(isPresented: $showOptionsView) {
            OptionsView(mapType: $mapType,
                        typeService: $serviceViewModel.typeServiceSelected,
                        rayOfDistance: $serviceViewModel.rayOfDistance, onDismiss: {
                            mapView.loadMap()
                        })
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
                showOptionsView.toggle()
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
            Text(serviceViewModel.typeServiceSelected.title())
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

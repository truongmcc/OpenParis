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
    @State private var map: MKMapView?
    @State private var mapType = MKMapType.standard
    @State private var showOptionsView = false
    @State private var showLoadingView = false
    @State private var showErrorAlert = false
    @State private var alertError: Alert?
    
    var body: some View {
        ZStack {
            MapView(mapViewModel: mapViewModel,
                    serviceViewModel: serviceViewModel,
                    alertErrorDetected: $showErrorAlert,
                    alertError: $alertError,
                    showLoadingView: $showLoadingView)
            
            addTitle()
            showProgressionView()
            showServiceDetail()
            addButtons()
        }
        .onTapGesture {
            serviceViewModel.service = nil
        }
        
        .alert(isPresented: $showErrorAlert) {
            return (alertError ?? Alert(title: Text(NetworkError.unknown.description)))
        }
        
        .sheet(isPresented: $showOptionsView) {
            OptionsView(mapType: $mapType, typeService: $serviceViewModel.typeServiceSelected) {
                refreshAllAnnotations()
            }
        }
        
        .onAppear() {
            refreshAllAnnotations()
        }
    }
}

extension ContentView {
    
    fileprivate func refreshAllAnnotations() {
        serviceViewModel.service = nil
        showLoadingView = true
        map?.isUserInteractionEnabled = false
        mapViewModel.fetchAllAnnotations(of: serviceViewModel.typeServiceSelected)
        { result in
            map?.isUserInteractionEnabled = true
            showLoadingView = false
            manageAnnotationsResults(result: result)
        }
        mapViewModel.annotations.removeAll()
    }
    
    fileprivate func manageAnnotationsResults(result: Result<ResponseAnnotationDatas, NetworkError>) {
        switch result {
        case .success(let data):
            if let dataResults = data.records {
                DispatchQueue.main.async {
                    mapViewModel.createAnnotations(results: dataResults)
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                alertError = AlertManager.shared.createNetworkAlert(error)
                showErrorAlert = true
            }
        }
    }
    
    fileprivate func showServiceDetail() -> AnyView? {
        guard let service = serviceViewModel.service else { return nil }
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
    
    fileprivate func addButtons() -> some View {
        return
            GeometryReader { geometryReader in
                VStack {
                    Button("Ma position", action: {
                        mapViewModel.centerUserLocation.toggle()
                    })
                    .padding(20)
                    .multilineTextAlignment(.trailing)
                    
                    Button("Options", action: {
                        showOptionsView.toggle()
                    })
                    .padding(20)
                }
                .foregroundColor(Color.primary)
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .bottomTrailing)
            }
    }
    
    fileprivate func addTitle() -> some View {
        VStack {
            Text(serviceViewModel.typeServiceSelected.title())
                .foregroundColor(.primary)
                .font(.title)
                .padding(20)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var map: MKMapView?
    @State private var mapType = MKMapType.standard
    
    @ObservedObject var mapViewModel = MapViewModel()
    @ObservedObject var serviceViewModel = ServiceViewModel()
    
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
                    //mapType: $mapType,
                    showLoadingView: $showLoadingView)
            
            addTitle()
            
            showProgressionView()
            showServiceDetail()
            addMenuButton()
        }
        .onTapGesture {
            serviceViewModel.serviceSelected = nil
        }
        
        .alert(isPresented: $showErrorAlert) {
            return (alertError ?? Alert(title: Text(NetworkError.unknown.description)))
        }
        
        .sheet(isPresented: $showOptionsView) {
            OptionsView(mapType: $mapType, service: $serviceViewModel.service) {
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
        serviceViewModel.serviceSelected = nil
        showLoadingView = true
        map?.isUserInteractionEnabled = false
        mapViewModel.fetchAllAnnotations(of: serviceViewModel.service)
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
        switch serviceViewModel.serviceSelected {
        case is Velib:
            return AnyView(VelibDetailView(serviceSelected: serviceViewModel.serviceSelected as? Velib))
        case is Trotinette:
            return AnyView(TrotinetteDetailView(serviceSelected: serviceViewModel.serviceSelected as? Trotinette))
        case is Sanisette:
            return AnyView(SanisetteDetailView(serviceSelected: serviceViewModel.serviceSelected as? Sanisette))
        case is Fontaine:
            return AnyView(FontaineDetailView(serviceSelected: serviceViewModel.serviceSelected as? Fontaine))
        case is TriMobile:
            return AnyView(TriMobileDetailView(serviceSelected: serviceViewModel.serviceSelected as? TriMobile))
        default:
            return nil
        }
    }
    
    fileprivate func showProgressionView() -> some View {
        VStack {
            if showLoadingView {
                ProgressView()
                    .foregroundColor(Color.primary)
            }
        }
    }
    
    fileprivate func addMenuButton() -> some View {
        return
            GeometryReader { geometryReader in
                VStack {
                    Button("Centrer", action: {
                        mapViewModel.centerUserLocation.toggle()
                    })
                    .padding(20)
                    
                    Button("Options", action: {
                        showOptionsView.toggle()
                    })
                    .padding(20)
                    
                }
                .foregroundColor(.primary)
                
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .bottomTrailing)
            }
    }
    
    fileprivate func addTitle() -> some View {
        VStack {
            Text(serviceViewModel.service.title())
                .foregroundColor(.primary)
                .font(.title)
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

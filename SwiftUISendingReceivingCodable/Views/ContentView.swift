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
    @State private var annotations: [Annotation]?
    @State private var mapType = MKMapType.standard
    @State private var refreshAnnotations = false
    @State var centerUserLocation = false
    
    @State private var service = ServicesEnum.velib
    @State private var serviceSelected: Any?
    
    @State private var showOptionsView = false
    
    @State private var showErrorAlert = false
    @State private var showProgressView = false
    @State private var alertError: Alert?
    
    var body: some View {
        ZStack {
            
            MapView(alertErrorDetected: $showErrorAlert,
                    alertError: $alertError,
                    mapType: $mapType,
                    service: $service,
                    annotations: $annotations,
                    showProgressView: $showProgressView,
                    serviceSelected: $serviceSelected,
                    refreshAnnotations: $refreshAnnotations,
                    centerUserLocation: $centerUserLocation)
            
            showProgressionView()
            showServiceDetail()
            addMenuButton()
            
        }
        .onTapGesture {
            serviceSelected = nil
        }
        
        .alert(isPresented: $showErrorAlert) {
            return (alertError ?? Alert(title: Text(NetworkError.unknown.description)))
        }
        
        .sheet(isPresented: $showOptionsView) {
            
            OptionsView(mapType: $mapType, service: $service) {
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
        showProgressView = true
        map?.isUserInteractionEnabled = false
        ServiceRepository.shared.fetchAllAnnotations(of: service)
        { result in
            map?.isUserInteractionEnabled = true
            showProgressView = false
            manageAnnotationsResults(result: result)
        }
    }
    
    fileprivate func manageAnnotationsResults(result: Result<ResponseAnnotationDatas, NetworkError>) {
        switch result {
        case .success(let data):
            if let dataResults = data.records {
                DispatchQueue.main.async {
                    self.createAnnotations(results: dataResults)
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
        switch serviceSelected {
        case is Velib:
            return AnyView(VelibDetailView(serviceSelected: serviceSelected as? Velib))
        case is Trotinette:
            return AnyView(TrotinetteDetailView(serviceSelected: serviceSelected as? Trotinette))
        case is Sanisette:
            return AnyView(SanisetteDetailView(serviceSelected: serviceSelected as? Sanisette))
        case is Fontaine:
            return AnyView(FontaineDetailView(serviceSelected: serviceSelected as? Fontaine))
        case is TriMobile:
            return AnyView(TriMobileDetailView(serviceSelected: serviceSelected as? TriMobile))
        default:
            return nil
        }
    }
    
    fileprivate func showProgressionView() -> some View {
        VStack {
            if showProgressView {
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
                        centerUserLocation.toggle()
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
    
    fileprivate func fetchAllAnnotations(of service: ServicesEnum) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: service.allAnnotationsUrl(), decodable: ResponseAnnotationDatas.self) {
            result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let dataResults = data.records {
                        self.createAnnotations(results: dataResults)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    alertError = AlertManager.shared.createNetworkAlert(error)
                    showErrorAlert = true
                }
            }
        }
    }
    
    fileprivate func createAnnotations(results: [AnnotationDataModel]) {
        refreshAnnotations = true
        var annos = [Annotation]()
        for annotation in results {
            annos.append(Annotation(data: annotation))
        }
        annotations = annos
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

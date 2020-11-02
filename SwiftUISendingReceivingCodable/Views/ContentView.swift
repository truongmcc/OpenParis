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
    @State private var velibSelected: Velib?
    @State private var trotinetteSelected: Trotinette?
    
    @State private var alertErrorDetected = false
    @State private var alertError: Alert?
    
    @State private var mapType = MKMapType.standard
    @State private var showOptionsView = false
    @State private var service = Services.velib
        
    var body: some View {
        ZStack {
            
            MapView(alertErrorDetected: $alertErrorDetected,
                    velibSelected: $velibSelected, trotinetteSelected: $trotinetteSelected, alertError: $alertError, mapType: $mapType, service: $service, annotations: $annotations)
            
            if velibSelected != nil {
                DetailVelibView(velibSelected: velibSelected)
            }
            
            if trotinetteSelected != nil {
                DetailTrotinetteView(trotinetteSelected: trotinetteSelected)
            }
            
            addMenuButton()
   
        }
        .onTapGesture {
            velibSelected = nil
            trotinetteSelected = nil
        }
        
        .alert(isPresented: $alertErrorDetected) {
            return (alertError ?? Alert(title: Text(NetworkError.unknown.description)))
        }
        
        .sheet(isPresented: $showOptionsView) {
            OptionsView(mapType: $mapType, service: $service) {
                fetchAllAnnotations(of: service)
            }
        }
        
        .onAppear() {
            fetchAllAnnotations(of: service)
        }
    }
    
    fileprivate func addMenuButton() -> some View {
        return
            GeometryReader { geometryReader in
                Button("Options", action: {
                    showOptionsView.toggle()
                })
                .foregroundColor(.primary)
                .padding(20)
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .topTrailing)
            }
    }
    
    fileprivate func fetchAllAnnotations(of service: Services) {
        WebServiceManager.shared.fetchDataWithTypeResult(url: service.urlForAll(), decodable: ResponseAnnotationDatas.self) {
            result in
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
                    alertErrorDetected = true
                }
            }
        }
    }
    
    fileprivate func createAnnotations(results: [AnnotationDataModel]) {
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

//
//  ContentView.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 23/07/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var map: MKMapView?
    @State var annotations: [Annotation]?
    @State var velibSelected: Velib?
    
    @State var alertErrorDetected = false
    @State var alertError: Alert?
    
    @State private var mapType = MKMapType.standard
    @State var showOptionsView = false
    @State var service = Services.velib
        
    var body: some View {
        ZStack {
            
            MapView(alertErrorDetected: $alertErrorDetected,
                    velibSelected: $velibSelected, alertError: $alertError, mapType: $mapType, service: $service, annotations: $annotations)
            
            if velibSelected != nil {
                DetailVelibView(velibSelected: velibSelected)
            }
            
            addMenuButton()
   
        }
        .onTapGesture {
            velibSelected = nil
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
        WebServiceManager.shared.fetchDataWithTypeResult(url: service.url(), decodable: ResponseAnnotationDatas.self) {
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
                    alertError = AlertManager.shared.createErrorAlert(error)
                    alertErrorDetected = true
                }
            }
        }
    }
    
    fileprivate func createAnnotations(results: [AnnotationDatas]) {
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

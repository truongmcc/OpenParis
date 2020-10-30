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
    @State var velibSelected: Velib?
    @State var alertErrorDetected = false
    @State var alertError: Alert?
    @State var annotations: [Annotation]?
    @State private var mapType = MKMapType.standard
    @State var showMenuView = false
    
    @State var service = ServicesEnum.velib
    
    @State var test = false
    
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
        
        .sheet(isPresented: $showMenuView) {
            OptionsView(mapType: $mapType, service: $service) {
                fetchAll(service: service)
            }
        }
        
        .onAppear() {
            fetchAll(service: service)
        }
    }
    
    fileprivate func addMenuButton() -> some View {
        return
            GeometryReader { geometryReader in
                Button("Options", action: {
                    showMenuView.toggle()
                })
                .foregroundColor(.primary)
                .padding(20)
                .frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .topTrailing)
            }
    }
    
    fileprivate func fetchAll(service: ServicesEnum) {
        var urlService = UrlDataLocationEnum.allVelibs.rawValue
        if service == .velib {
            urlService = UrlDataLocationEnum.allVelibs.rawValue
        } else {
            urlService = UrlDataLocationEnum.allTrotinettes.rawValue
        }
        WebServiceManager.shared.fetchDataWithTypeResult(url: urlService, decodable: ResponseAnnotationDatas.self) {
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

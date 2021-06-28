//
//  MapViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 05/11/2020.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    @Published var locationManager = CLLocationManager()
    @Published var annotations = [ServiceAnnotation]()
    @Published var centerUserLocation = false
    @Published var centerOnAnnotation = false
    @Published var shouldeRefreshAnnotations = false
    @Published var centerCoordinate: CLLocationCoordinate2D?
    
    func createAnnotations(results: [AnnotationDataModel]) {
        shouldeRefreshAnnotations = true
        for annotation in results {
            annotations.append(ServiceAnnotation(data: annotation))
        }
        annotations = sortByDistance()!
    }
    
    func fetchAllAnnotations(of userSettings: UserSettings, completion: @escaping (Result<ResponseAnnotationDatas, NetworkErrorEnum>) -> Void) {
        var rayOfDistance = ""
        if userSettings.rayOfDistance <= 700 {
            rayOfDistance = "&geofilter.distance=\(centerCoordinate?.latitude ?? 0)%2C\(centerCoordinate?.longitude ?? 0)%2C\(String(userSettings.rayOfDistance))"
        }
        let endPoint = userSettings.typeService.allAnnotationsEndpoint() + rayOfDistance

        RepositoryNetworking.shared.fetchAllAnnotations(endPoint: endPoint)
        { result in
            completion(result)
        }
    }
    
    func sortByDistance() -> [ServiceAnnotation]? {
        for annotation in annotations {
            let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            
            locationManager.location?.distance(from: location)
        }
        return annotations.sorted { a,b in
            let locationA = CLLocation(latitude: a.coordinate.latitude, longitude: a.coordinate.longitude)
            let locationB = CLLocation(latitude: b.coordinate.latitude, longitude: b.coordinate.longitude)
            return (locationManager.location?.distance(from: locationA))! < (locationManager.location?.distance(from: locationB))!
        }
    }
}


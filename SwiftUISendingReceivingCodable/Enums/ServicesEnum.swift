//
//  ServicesEnum.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/11/2020.
//

import Foundation
import SwiftUI

enum ServicesEnum: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case velib
    case trotinette
    case sanisette
    case fontaine
    case triMobile
    case arbreRemarquable
    case wifiHotspot
    case colonneVerre
    
    func title() -> String {
        switch self {
        case .velib:
            return "Velibs"
        case .trotinette:
            return "Trotinettes"
        case .sanisette:
            return "Sanisettes"
        case .fontaine:
            return "Fontaines"
        case .triMobile:
            return "Tri Mobile"
        case .arbreRemarquable:
            return "Arbres remarquables"
        case .wifiHotspot:
            return "Hotspots Wifi"
        case .colonneVerre:
            return "Colonne de verre"
        }
    }
    
    func allAnnotationsEndpoint() -> String {
        let openDataBaseUrl = "https://opendata.paris.fr/api/records/1.0/search"
        let openParisBaseUrl = "https://opendata.paris.fr/api/records/1.0/search"
        switch self {
        case .velib:
            return openDataBaseUrl + "/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000"
        case .trotinette:
            return openDataBaseUrl + "/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1000"
        case .sanisette:
            return openDataBaseUrl + "/?dataset=sanisettesparis&q=&rows=1000"
        case .fontaine:
            return openDataBaseUrl + "/?dataset=fontaines-a-boire&q=&rows=1000"
        case .triMobile:
            return openDataBaseUrl + "/?dataset=tri-mobile0&q=&rows=1000"
        case .arbreRemarquable:
            return openParisBaseUrl + "/?dataset=arbresremarquablesparis&q=&rows=1000"
        case .wifiHotspot:
            return openDataBaseUrl + "/?dataset=sites-disposant-du-service-paris-wi-fi&q=&rows=1000"
        case .colonneVerre:
            return openDataBaseUrl + "/?dataset=dechets-menagers-points-dapport-volontaire-colonnes-a-verre&q=&rows=1000"
        }
    }
    
    func annotationEndpoint() -> String {
        let openDataBaseUrl = "https://opendata.paris.fr/api/records/1.0/search"
        let openParisBaseUrl = "https://opendata.paris.fr/api/records/1.0/search"
        switch self {
        case .velib:
            return
                openDataBaseUrl + "/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
        case .trotinette:
            return openDataBaseUrl + "/?dataset=emplacements-de-stationnement-trottinettes&q=recordid%3D"
        case .sanisette:
            return openDataBaseUrl + "/?dataset=sanisettesparis&q=recordid%3D"
        case .fontaine:
            return openDataBaseUrl + "/?dataset=fontaines-a-boire&q=recordid%3D"
        case .triMobile:
            return
                openDataBaseUrl + "/?dataset=tri-mobile0&q=recordid%3D"
        case .arbreRemarquable:
            return openDataBaseUrl + "/?dataset=arbresremarquablesparis&q=recordid%3D"
        case .wifiHotspot:
            return openParisBaseUrl + "/?dataset=sites-disposant-du-service-paris-wi-fi&q=recordid%3D"
        case .colonneVerre:
            return openDataBaseUrl + "/?dataset=dechets-menagers-points-dapport-volontaire-colonnes-a-verre&q=recordid+%3D"
        }
    }
    
    func type<T>() -> T {
        switch self {
        case .velib:
            return VelibResponse.self as! T
        case .trotinette:
            return TrotinetteResponse.self as! T
        case .sanisette:
            return SanisetteResponse.self as! T
        case .fontaine:
            return FontaineResponse.self as! T
        case .triMobile:
            return TriMobileResponse.self as! T
        case .arbreRemarquable:
            return ArbreRemarquableResponse.self as! T
        case .wifiHotspot:
            return WifiHotspotResponse.self as! T
        case .colonneVerre:
            return ColonneVerreResponse.self as! T
        }
    }
    
    func type2() -> Response.Type {
        switch self {
        
        case .velib:
            return VelibResponse.self
        case .trotinette:
            return TrotinetteResponse.self
        case .sanisette:
            return SanisetteResponse.self
        case .fontaine:
            return FontaineResponse.self
        case .triMobile:
            return TriMobileResponse.self
        case .arbreRemarquable:
            return ArbreRemarquableResponse.self
        case .wifiHotspot:
            return WifiHotspotResponse.self
        case .colonneVerre:
            return ColonneVerreResponse.self
        }
    }
    
    func create() -> Service {
        switch self {
        case .velib:
            return Velib()
        case .trotinette:
            return Trotinette()
        case .sanisette:
            return Sanisette()
        case .fontaine:
            return Fontaine()
        case .triMobile:
            return TriMobile()
        case .arbreRemarquable:
            return ArbreRemarquable()
        case .wifiHotspot:
            return WifiHotspot()
        case .colonneVerre:
            return ColonneVerre()
        }
    }
    
    @ViewBuilder
    func createDetailView(serviceSelected: Service) -> some View {
        switch self {
        case .velib:
            ConcreteVelibDetailView().create(service: serviceSelected) as? VelibDetailView
        case .trotinette:
            ConcreteTrotinetteDetailView().create(service: serviceSelected) as? TrotinetteDetailView
        case .sanisette:
            ConcreteSanisetteDetailView().create(service: serviceSelected) as? SanisetteDetailView
        case .fontaine:
            ConcreteFontaineDetailView().create(service: serviceSelected) as? FontaineDetailView
        case .triMobile:
            ConcreteTriMobileDetailView().create(service: serviceSelected) as? TriMobileDetailView
        case .arbreRemarquable:
            ConcreteArbreRemarquableDetailView().create(service: serviceSelected) as? ArbreRemarquableDetailView
        case .wifiHotspot:
            ConcreteWifiHotspotDetailView().create(service: serviceSelected) as? WifiHotspotDetailView
        case .colonneVerre:
            ConcreteColonneVerreDetailView().create(service: serviceSelected) as? ColonneVerreDetailView
        }
    }
}

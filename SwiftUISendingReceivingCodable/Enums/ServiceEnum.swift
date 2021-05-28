//
//  ServiceEnum.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/11/2020.
//

import Foundation

enum ServicesEnum: String, CaseIterable {
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
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1000"
        case .sanisette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis&q=&rows=1000"
        case .fontaine:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=fontaines-a-boire&q=&rows=1000"
        case .triMobile:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=tri-mobile0&q=&rows=1000"
        case .arbreRemarquable:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=arbresremarquablesparis&q=&rows=1000"
        case .wifiHotspot:
            return "https://parisdata.opendatasoft.com/api/records/1.0/search/?dataset=sites-disposant-du-service-paris-wi-fi&q=&rows=1000"
        case .colonneVerre:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=dechets-menagers-points-dapport-volontaire-colonnes-a-verre&q=&rows=1000"
        }
    }
    
    func annotationEndpoint() -> String {
        switch self {
        case .velib:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=recordid%3D"
        case .sanisette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis&q=recordid%3D"
        case .fontaine:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=fontaines-a-boire&q=recordid%3D"
        case .triMobile:
            return
                "https://opendata.paris.fr/api/records/1.0/search/?dataset=tri-mobile0&q=recordid%3D"
        case .arbreRemarquable:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=arbresremarquablesparis&q=recordid%3D"
        case .wifiHotspot:
            return "https://parisdata.opendatasoft.com/api/records/1.0/search/?dataset=sites-disposant-du-service-paris-wi-fi&q=recordid%3D"
        case .colonneVerre:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=dechets-menagers-points-dapport-volontaire-colonnes-a-verre&q=recordid+%3D"
        }
    }
    
    func type<T>() -> T.Type {
        switch self {
        case .velib:
            return VelibResponse.self as! T.Type
        case .trotinette:
            return TrotinetteResponse.self as! T.Type
        case .sanisette:
            return SanisetteResponse.self as! T.Type
        case .fontaine:
            return FontaineResponse.self as! T.Type
        case .triMobile:
            return TriMobileResponse.self as! T.Type
        case .arbreRemarquable:
            return ArbreRemarquableResponse.self as! T.Type
        case .wifiHotspot:
            return WifiHotspotResponse.self as! T.Type
        case .colonneVerre:
            return ColonneVerreResponse.self as! T.Type
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
    
}

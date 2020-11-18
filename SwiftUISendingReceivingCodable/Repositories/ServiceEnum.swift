//
//  ServiceEnum.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 18/11/2020.
//

import Foundation

enum ServicesEnum: Int {
    case velib
    case trotinette
    case sanisette
    case fontaine
    case triMobile
    
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
        }
    }
    
    func allAnnotationsUrl() -> String {
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
        }
    }
    
    func annotationUrl() -> String {
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
        }
    }
    
}

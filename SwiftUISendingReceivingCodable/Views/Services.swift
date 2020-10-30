//
//  Services.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/10/2020.
//

enum Services: Int {
    case velib
    case trotinette
    
    func url() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000&facet=name&facet=is_installed&facet=is_renting&facet=is_returning&facet=nom_arrondissement_communes"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1300"
        }
    }
}

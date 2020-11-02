//
//  WebServiceRepository.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 02/11/2020.
//

import Foundation

enum Services: Int {
    case velib
    case trotinette
    
    func urlForAll() -> String {
        switch self {
        case .velib:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=&rows=1000&facet=name&facet=is_installed&facet=is_renting&facet=is_returning&facet=nom_arrondissement_communes"
        case .trotinette:
            return "https://opendata.paris.fr/api/records/1.0/search/?dataset=emplacements-de-stationnement-trottinettes&q=&rows=1300"
        }
    }
}

enum UrlDataLocationEnum: String {
    case velib = "https://opendata.paris.fr/api/records/1.0/search/?dataset=velib-disponibilite-en-temps-reel&q=recordid%3D"
}


class WebServiceRepository {
    
    static let shared = WebServiceRepository()
    private init() { }

    func fetchVelib(recordid: String) {
        let url = UrlDataLocationEnum.velib.rawValue + recordid
        WebServiceManager.shared.fetchDataWithTypeResult(url: url,
                                    decodable: VelibResponse.self) { result in
//            switch result {
//            case .success(let data):
//                DispatchQueue.main.async {
//                    if let velibs = data.records, velibs.count > 0 {
//                        self.createVelibDetail(velibs)
//                    } else {
////                        alertError = AlertManager.shared.createNetworkAlert(NetworkError.serverLost)
////                        alertErrorDetected = true
//                    }
//                }
//            case .failure(let error):
//                alertError = AlertManager.shared.createNetworkAlert(error)
//                alertErrorDetected = true
//            }
        }
    }
}

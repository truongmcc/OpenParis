//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

class ServiceViewModel: ObservableObject {
    @Published var service: Service?
    var userSettings: UserSettings?
    
    func fetchAnnotationDetail(recordId: String,
                                completionHandler: @escaping (Bool, NetworkErrorEnum?) -> Void) {
        guard let urls = userSettings?.typeService.annotationEndpoint() else { return }
        let url = urls + recordId
        service = userSettings?.typeService.create()

        guard let typeService = userSettings?.typeService else { return }
        
       // let typeResponse = userSettings?.typeService.type2()
        switch userSettings?.typeService {
        
        case .velib:
            service?.fetchDetail(of: typeService, urlString: url, type: VelibResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .trotinette:
            service?.fetchDetail(of: typeService, urlString: url, type: TrotinetteResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .sanisette:
            service?.fetchDetail(of: typeService, urlString: url, type: SanisetteResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .fontaine:
            service?.fetchDetail(of: typeService, urlString: url, type: FontaineResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .triMobile:
            service?.fetchDetail(of: typeService, urlString: url, type: TriMobileResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .arbreRemarquable:
            service?.fetchDetail(of: typeService, urlString: url, type: ArbreRemarquableResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .wifiHotspot:
            service?.fetchDetail(of: typeService, urlString: url, type: WifiHotspotResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        case .colonneVerre:
            service?.fetchDetail(of: typeService, urlString: url, type: ColonneVerreResponse.self) { service, showError, networkError in
                DispatchQueue.main.async {
                    self.service = service
                    completionHandler(showError, networkError)
                }
            }
        
        case .none:
            break
        }
//        var typeResponse = userSettings?.typeService.type2()
////        if userSettings?.typeService.type() == VelibResponse.self {
////            typeResponse = VelibResponse.self
////        }
//        //let typeResponse = userSettings?.typeService.type2()
//        service?.fetchDetail2(of: typeService, urlString: url, type: typeResponse) { service, showError, networkError in
//            DispatchQueue.main.async {
//                self.service = service
//                completionHandler(showError, networkError)
//            }
//        }
    }
}

//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

class ServiceViewModel: ObservableObject {
    @Published var serviceSelected: Any?
    @Published var service = ServicesEnum.velib
    func fetchAnnotationDetail(recordId: String, finished: @escaping (Bool, Alert?) -> Void) {
        let url = service.annotationUrl() + recordId
        switch service {
        case .velib:
            ServiceRepository.shared.fetchVelib(urlString: url) { result in
                self.manageServiceResult(result: result) { showError, alert  in
                    finished(showError, alert ?? nil)
                }
            }
        case .trotinette:
            ServiceRepository.shared.fetchTrotinette(urlString: url) { result in
                self.manageServiceResult(result: result) { showError, alert  in
                    finished(showError, alert ?? nil)
                }
            }
        case .sanisette:
            ServiceRepository.shared.fetchSanisette(urlString: url) { result in
                self.manageServiceResult(result: result) { showError, alert  in
                    finished(showError, alert ?? nil)
                }
            }
        case .fontaine:
            ServiceRepository.shared.fetchFontaine(urlString: url) { result in
                self.manageServiceResult(result: result) { showError, alert  in
                    finished(showError, alert ?? nil)
                }
            }
        case .triMobile:
            ServiceRepository.shared.fetchTriMobile(urlString: url) { result in
                self.manageServiceResult(result: result) { showError, alert  in
                    finished(showError, alert ?? nil)
                }
            }
        }
    }
    
    func manageServiceResult<T>(result: Result<T, NetworkError>, completion: @escaping (Bool, Alert?) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.createDetail(data: data)
                completion(false, nil)
            case .failure(let error):
                completion(true, AlertManager.shared.createNetworkAlert(error))
            }
        }
    }
    
    func createDetail<T>(data: T) {
        if let dataResponse = data as? VelibResponse, let velib = dataResponse.records?.first {
            self.serviceSelected = velib
        } else if let dataResponse = data as? TrotinetteResponse, let trotinette = dataResponse.records?.first {
            self.serviceSelected = trotinette
        } else if let dataResponse = data as? SanisetteResponse, let sanisette = dataResponse.records?.first {
            self.serviceSelected = sanisette
        } else if let dataResponse = data as? FontaineResponse, let fontaine = dataResponse.records?.first {
            self.serviceSelected = fontaine
        } else if let dataResponse = data as? TriMobileResponse, let triMobile = dataResponse.records?.first {
            self.serviceSelected = triMobile
        }
    }
}

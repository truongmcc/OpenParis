//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

class ServiceViewModel: ObservableObject {
    @Published var service: Service?
    @Published var typeServiceSelected = ServicesEnum.velib
    
    func fetchAnnotationDetail(recordId: String, finished: @escaping (Bool, Alert?) -> Void) {
        let url = typeServiceSelected.annotationUrl() + recordId
        switch typeServiceSelected {
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
                if self.createDetail(data: data) {
                    completion(false, nil)
                } else {
                    completion(true, AlertManager.shared.createNetworkAlert(NetworkError.dataNotFound))
                }
            case .failure(let error):
                completion(true, AlertManager.shared.createNetworkAlert(error))
            }
        }
    }
    
    func createDetail<T>(data: T) -> Bool {
        var dataFound = true
        if let dataResponse = data as? VelibResponse, let velib = dataResponse.records?.first {
            self.service = velib
        } else if let dataResponse = data as? TrotinetteResponse, let trotinette = dataResponse.records?.first {
            self.service = trotinette
        } else if let dataResponse = data as? SanisetteResponse, let sanisette = dataResponse.records?.first {
            self.service = sanisette
        } else if let dataResponse = data as? FontaineResponse, let fontaine = dataResponse.records?.first {
            self.service = fontaine
        } else if let dataResponse = data as? TriMobileResponse, let triMobile = dataResponse.records?.first {
            self.service = triMobile
        } else {
            dataFound = false
        }
        return dataFound
    }
}

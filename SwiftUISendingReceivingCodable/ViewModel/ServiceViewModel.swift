//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

protocol Service {
    var typeService: ServicesEnum { get set }
}

class ServiceViewModel: ObservableObject {
    @Published var service: Service?
    @Published var typeServiceSelected = ServicesEnum.velib
    
    typealias velibResponseAlias = Result<VelibResponse, NetworkError>
    typealias trotinetteResponseAlias = Result<TrotinetteResponse, NetworkError>
    typealias SanisetteResponseAlias = Result<SanisetteResponse, NetworkError>
    typealias fontaineResponseAlias = Result<FontaineResponse, NetworkError>
    typealias triMobileResponseAlias = Result<TriMobileResponse, NetworkError>
    
    func fetchAnnotationDetail(recordId: String,
                                finished: @escaping (Bool, NetworkError?) -> Void) {
        
        let url = typeServiceSelected.annotationUrl() + recordId
        
        switch typeServiceSelected {
        case .velib:
            
            
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( _ result: velibResponseAlias) in
                self.manageServiceResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError)
                }
            }
            
        case .trotinette:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( _ result: trotinetteResponseAlias) in
                self.manageServiceResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError)
                }
            }
        case .sanisette:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( _ result: SanisetteResponseAlias) in
                self.manageServiceResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError)
                }
            }
        case .fontaine:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( _ result: fontaineResponseAlias) in
                self.manageServiceResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError)
                }
            }
        case .triMobile:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( _ result: triMobileResponseAlias) in
                self.manageServiceResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError)
                }
            }
        }
    }
    
    func manageServiceResult<T>(result: Result<T, NetworkError>, completion: @escaping (Bool, NetworkError?) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                if self.createDetail(data: data) {
                    completion(false, nil)
                } else {
                    completion(true, NetworkError.dataNotFound)
                }
            case .failure(let error):
                completion(true, error)
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

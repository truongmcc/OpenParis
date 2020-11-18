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

protocol serviceResponseAliasProtocol {
    typealias velibResult = Result<VelibResponse, NetworkError>
    typealias trotinetteResult = Result<TrotinetteResponse, NetworkError>
    typealias SanisetteResult = Result<SanisetteResponse, NetworkError>
    typealias fontaineResult = Result<FontaineResponse, NetworkError>
    typealias triMobileResult = Result<TriMobileResponse, NetworkError>
}

class ServiceViewModel:serviceResponseAliasProtocol, ObservableObject {
    @Published var service: Service?
    @Published var typeServiceSelected = ServicesEnum.velib
 
    func fetchAnnotationDetail(recordId: String,
                                finished: @escaping (Bool, NetworkError?) -> Void) {

        let url = typeServiceSelected.annotationUrl() + recordId
        switch typeServiceSelected {
        case .velib:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( result: velibResult) in
                self.manageResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError) } }
        case .trotinette:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( result: trotinetteResult) in
                self.manageResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError) } }
        case .sanisette:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( result: SanisetteResult) in
                self.manageResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError) } }
        case .fontaine:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( result: fontaineResult) in
                self.manageResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError) } }
        case .triMobile:
            ServiceRepository.shared.fetchDetail(of: typeServiceSelected,
                                                 urlString: url) { ( result: triMobileResult) in
                self.manageResult(result: result) {
                    showError, netWorkError  in
                    finished(showError, netWorkError) } }
        }
    }
    
    func manageResult<T>(result: Result<T, NetworkError>, completion: @escaping (Bool, NetworkError?) -> Void) {
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                if self.createService(data: data) {
                    completion(false, nil)
                } else {
                    completion(true, NetworkError.dataNotFound)
                }
            case .failure(let error):
                completion(true, error)
            }
        }
    }
    
    func createService<T>(data: T) -> Bool {
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

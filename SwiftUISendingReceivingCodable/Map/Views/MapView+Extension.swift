//
//  MapView+Extension.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 29/06/2021.
//

import Foundation

protocol MapViewProtocol {
    func showAnnotationDetail(recordId: String)
    func showAllAnnotations()
    func manageAnnotationsResults(result: Result<ResponseAnnotationDatas, NetworkErrorEnum>)
}

//MARK: MapViewProtocol
extension MapView {
    func showAnnotationDetail(recordId: String) {
        showLoadingView = true
        mapViewModel.shouldeRefreshAnnotations = false
        serviceViewModel.fetchAnnotationDetail(recordId: recordId) { showError, networkError in
            showLoadingView = false
            showErrorAlert = showError
            if let error = networkError {
                AlertManager.shared.netWorkError = error
            }
        }
    }
    
    func showAllAnnotations() {
        showLoadingView = true
        mapViewModel.fetchAllAnnotations(of: userSettings)
        { result in
            showLoadingView = false
            manageAnnotationsResults(result: result)
        }
        mapViewModel.annotations.removeAll()
    }
    
    func manageAnnotationsResults(result: Result<ResponseAnnotationDatas, NetworkErrorEnum>) {
        switch result {
        case .success(let data):
            if let dataResults = data.records {
                DispatchQueue.main.async {
                    mapViewModel.createAnnotations(results: dataResults)
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                AlertManager.shared.netWorkError = error
                showErrorAlert = true
            }
        }
    }
}

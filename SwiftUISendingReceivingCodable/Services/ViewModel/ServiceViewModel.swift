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
 
    func fetchAnnotationDetail(recordId: String,
                                finished: @escaping (Bool, NetworkError?) -> Void) {

        let url = typeServiceSelected.annotationEndpoint() + recordId
        
        service = typeServiceSelected.create()
        service?.fetchDetail(of: typeServiceSelected, urlString: url) { service, showError, networkError in
            DispatchQueue.main.async {
                self.service = service
                finished(showError, networkError)
            }
        }
    }
}

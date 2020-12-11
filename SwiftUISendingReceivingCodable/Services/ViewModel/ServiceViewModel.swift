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
                                finished: @escaping (Bool, NetworkError?) -> Void) {

        guard let urls = userSettings?.typeService.annotationEndpoint() else { return }
        let url = urls + recordId
        guard let typeService = userSettings?.typeService else { return }
        service = userSettings?.typeService.create()
        service?.fetchDetail(of: typeService, urlString: url) { service, showError, networkError in
            DispatchQueue.main.async {
                self.service = service
                finished(showError, networkError)
            }
        }
    }
}

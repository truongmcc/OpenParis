//
//  ServiceViewModel.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 06/11/2020.
//

import SwiftUI

protocol ServiceProtocol {

}

class ServiceViewModel: ServiceProtocol, ObservableObject {
    @Published var serviceSelected: Any?
    @Published var service = ServicesEnum.velib
}

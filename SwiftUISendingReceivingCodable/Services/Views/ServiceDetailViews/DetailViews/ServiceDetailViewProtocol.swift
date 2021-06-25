//
//  ServiceDetailViewProtocol.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 25/06/2021.
//

import SwiftUI

protocol ServiceDetailViewProtocol {
    func createServiceView<T>(serviceSelected: Service?) -> T
}

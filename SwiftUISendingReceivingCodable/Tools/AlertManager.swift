//
//  AlertManager.swift
//  SwiftUISendingReceivingCodable
//
//  Created by picshertho on 30/10/2020.
//

import Foundation
import SwiftUI

class AlertManager {
    
    static let shared = AlertManager()
    private init() { }
    
    let netWorkError: NetworkError = .unknown
    
    func createNetworkAlert(_ error: NetworkError?, shouldReloadMap: Bool = true) -> Alert {
        return Alert(title: Text("Network Error"),
                     message: Text(error?.description ?? "Unknown error"),
                     dismissButton: .default(Text("OK")) {
        })
    }
}

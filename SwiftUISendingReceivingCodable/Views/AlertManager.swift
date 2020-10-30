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
    
    func createErrorAlert(_ error: NetworkError?) -> Alert {
        return Alert(title: Text("Network Error"), message: Text(error?.description ?? "Unknown error"), dismissButton: .default(Text("OK")) {
        })
    }
}

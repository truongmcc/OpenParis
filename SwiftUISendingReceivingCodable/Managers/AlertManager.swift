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
    
    var netWorkError: NetworkError?
    
    func createNetworkAlert(completionHandler: @escaping (Bool) -> Void) -> Alert {
        return Alert(title: Text("Network Error"),
                     message: Text(netWorkError?.description ?? "Unknown error"),
                     dismissButton: .default(Text("OK")) {
                        if self.netWorkError == NetworkError.requestFailed {
                            completionHandler(false)
                        } else {
                            completionHandler(true)
                        }
                        
        })
    }
}
